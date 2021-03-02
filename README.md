# Publish Ruby Gem GitHub Action

This simple action will search for all `*.gemspec` files in working directory, and then build and push a gem for each of them, using the API token that you should provide in the `api-key` parameter. A good way to store it is using Github [Encrypted secrets](https://docs.github.com/en/actions/reference/encrypted-secrets) and [Environments](https://docs.github.com/en/actions/reference/environments) features.

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
