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

### Heroku
When building on heroku, make sure you set the revision based on the `SOURCE_VERSION` environment variable. This variable is set during the build phase and will be equal to the `HEROKU_SLUG_COMMIT` revision on runtime. Note that you should have [heroku dyno metadata](https://devcenter.heroku.com/articles/dyno-metadata) enabled.
```yaml
default:
  revision: "<%= ENV['SOURCE_VERSION'] || ENV.fetch('HEROKU_SLUG_COMMIT', 'unknown') %>"
```

## Publishing a new version
The [publish workflow](.github/workflows/publish.yml) listens to a new release in GitHub. 
