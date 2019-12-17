# TinyTdsWrapper

This wrapper manages connection health. It will reconnnect automatically when TinyTds throws an error. It can be used with connection pooling gems.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tiny_tds_wrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tiny_tds_wrapper

## Usage

```ruby
  def prepare_connection_pool!
    @@pool ||= ConnectionPool.new(size: 100, timeout: 5) { TinyTdsWrapper::Client.new(config) }
  end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tiny_tds_wrapper.
