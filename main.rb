# frozen_string_literal: true

require "tempfile"

def system!(*cmd)
  puts "Running #{cmd.inspect}"

  Tempfile.create do |tempfile|
    begin
      system(*cmd, out: tempfile, exception: true)
    rescue => error
      tempfile.rewind
      output = tempfile.read
      raise "Failed to run command. Got exception: #{error.inspect}. Command output:\n#{output}"
    end
  end
end

workdir = ENV.fetch("WORKDIR", ".")
Dir.chdir(workdir)

Dir.glob("*.gemspec").each do |gemspec_file|
  puts "Building #{gemspec_file}"
  gemspec = Gem::Specification.load(gemspec_file)
  gem_file = gemspec.full_name + ".gem"
  system!("gem", "build", gemspec_file)

  begin
    system!("gem", "push", gem_file)
  rescue => error
    if error.message.include?("Repushing of gem versions is not allowed")
      warn "Gem with this version already exists"
    else
      raise
    end
  end
end
