# Appsignal Sourcemaps
This ruby gem uploads (private) sourcemaps to Appsignal using the [Sourcemaps API](https://docs.appsignal.com/api/sourcemaps.html).

## Installation
To start using this gem, add it to the `Gemfile` of your application:
```ruby
source 'https://rubygems.pkg.github.com/drieam' do
  gem 'appsignal-sourcemap'
end
```
After running `bundle install` you should enable the gem by adding `upload_sourcemaps: true` to your `config/appsignal.yml` file:

```yaml
default:
  upload_sourcemaps: true
```

Also ensure that your `Rails.application.config.asset_host` is setup correctly since that is used to define the full URL of the assets.
The gem then uploads the sourcemaps after the `assets:precompile` rake task. 
It searches for all `.map` files within the `Rails.public_path` directory.

## Publishing a new version
The [publish workflow](.github/workflows/publish.yml) listens to a new release in GitHub. 
