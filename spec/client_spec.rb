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

    it "opens a connection when called" do
      allow(TinyTds::Client).to receive(:new).and_return client

      expect(wrapper).to receive(:connect!).and_call_original
      wrapper.execute("select")
    end
  end

  describe "connect!" do
    it "does not disconnect if the connection is active" do
      allow(TinyTds::Client).to receive(:new).and_return client
      allow(client).to receive(:active?).and_return true
      expect(wrapper).not_to receive(:disconnect!)
      wrapper.send(:connect!)
    end
  end

  describe "disconnect!" do
    it "closes the connection" do
      allow(TinyTds::Client).to receive(:new).and_return client
      allow(client).to receive(:execute).and_raise(TinyTds::Error.new("Unknown Error"))
      expect(wrapper).to receive(:disconnect!).once

      wrapper.execute("select") rescue TinyTds::Error
    end
  end

  describe "active?" do
    it "returns true when active" do
      allow(TinyTds::Client).to receive(:new).and_return client
      allow(client).to receive(:active?).and_return true

      wrapper.send(:connect!)
      expect(wrapper.send(:active?)).to be true
    end

    it "returns false when not active" do
      allow(TinyTds::Client).to receive(:new).and_return client
      allow(client).to receive(:active?).and_return false
      wrapper.send(:connect!)
      expect(wrapper.send(:active?)).to be false
    end
  end
end
