require "bundler/setup"
require "simplecov"
SimpleCov.start

require "tiny_tds_wrapper"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  class TinyTdsFaker
    attr_accessor :options

    def execute(sql); end
    def escape(str); end
    def close; end
  end
end


