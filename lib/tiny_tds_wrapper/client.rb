module TinyTdsWrapper
  class Client
    def initialize(config)
      @config = config
      @client = nil
    end

    def method_missing(method_name, *args, &block)
      connect!
      begin
        @client.send(method_name, *args, &block)
      rescue TinyTds::Error => e
        disconnect!
        raise e
      end
    end

    def connect!
      disconnect! unless active?
      @client ||= TinyTds::Client.new(@config)
    end

    def disconnect!
      @client.close if @client
      @client = nil
    end

    def active?
      @client && @client.active?
    end
  end
end
