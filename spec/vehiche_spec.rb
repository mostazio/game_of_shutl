require 'spec_helper'

describe Vehicle do
  describe "#find" do
    context "when passing an existing name" do
      it "returns the corrisponding vehicle" do
        name = :bicycle
        vehicle = Vehicle.find name

        vehicle.name.should == name
        vehicle.value.should == 1.1
        vehicle.limit.should == 500
      end
    end

    context "when passing a wrong name" do
      it "returns a nil object" do
        vehicle = Vehicle.find "blabla"

        vehicle.should be_nil
      end
    end
  end
end
