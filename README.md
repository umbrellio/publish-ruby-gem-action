# Publish Ruby Gem GitHub Action

Example usage:

```yaml
# ...

jobs:
  # ...

  deploy:
    runs-on: ubuntu-latest

    # You might want to use GitHub environment to protect your RubyGems API token
    environment: Deploy

    # Run on push to master branch in this case
    if: github.event_name == 'push' && github.ref == 'refs/heads/master'

    steps:
      - uses: actions/checkout@v1

      - uses: umbrellio/publish-ruby-gem-action@v1
        with:
          api-key: ${{secrets.RUBYGEMS_API_KEY}} # Required, your RubyGems API token with push permission
          working-directory: somedir # Optional, "." by default
```
