RSpec.describe TinyTdsWrapper::Client do
  let(:client){ TinyTdsFaker.new }
  let(:wrapper){ TinyTdsWrapper::Client.new({}) }

  describe "new" do
    it "requires one argument" do
      expect{ TinyTdsWrapper::Client.new }.to raise_error(ArgumentError, /(given 0, expected 1)/)
    end
  end

  describe "method_missing" do
    it "sends method to the client instance" do
      allow(TinyTds::Client).to receive(:new).and_return client
      expect(client).to receive(:execute)

      wrapper.execute("select")
    end

    it "opens a connection when method called" do
      allow(TinyTds::Client).to receive(:new).and_return client

      expect(wrapper).to receive(:connect!).and_call_original
      wrapper.execute("select")
    end
  end

  describe "connect!" do

  end

  describe "disconnect!" do
    it "closes the connection" do

      allow(TinyTds::Client).to receive(:new).and_return client
      allow(client).to receive(:execute).and_raise(TinyTds::Error.new("Unknown Error"))
      expect(wrapper).to receive(:disconnect!).once

      wrapper.execute("select") rescue TinyTds::Error
    end
  end
end
