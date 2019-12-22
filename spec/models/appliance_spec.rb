require 'spec_helper'

describe Appliance do
  context "#initialize" do
    it "Should throw exception if invalid params are passeed" do
      expect { Appliance.new("wrong state", 20) }.to raise_error("Invalid Appliance state")
    end
    it "Should not throw if valid params are passed" do
      expect(Appliance.new(STATE[:on], DEFAULT_UNITS[:ac]).power_usage).to eq(DEFAULT_UNITS[:ac])
      expect(Appliance.new(STATE[:on], DEFAULT_UNITS[:lights]).power_usage).to eq(DEFAULT_UNITS[:lights])
    end
  end
end