require 'spec_helper'

describe Delivery do
  let(:properties) do
    {
      pickup_postcode:   'SW1A 1AA',
      delivery_postcode: 'EC2A 3LT'
    }
  end

  subject { Delivery.new(properties) }

  context "when initialized" do
    it "can be initialized with an hash of properties" do
      delivery = Delivery.new(properties)

      delivery.pickup_postcode.should   == 'SW1A 1AA'
      delivery.delivery_postcode.should == 'EC2A 3LT'
    end

    it "ignores unknown parameters" do
      properties.merge(blabla: 123)

      subject.instance_variable_get("@blabla").should be_nil
    end
  end

  describe "#format_price" do
    it "returns the delivery price" do
      subject.format_price.should == "780.85"
    end
  end

  describe "#to_json" do
    let(:json) { { quote: properties.merge(price: subject.format_price, vehicle: subject.vehicle) }.to_json }

    it "returns a json representation of the quote" do
      subject.to_json.should == json
    end
  end
end
