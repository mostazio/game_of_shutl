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

  describe "can_deliver?" do
    context "when passing a deliver object" do
      context "when the delivery distance is less than the limit" do
        context "and it can fit the product" do
          it "returns true" do
            delivery = double("Delivery")
            delivery.stub(:distance).and_return(Vehicle::VEHICLES[:bicycle][:limit] - 10)
            delivery.stub(:products).and_return([{ "weight" => 2, "length" => 25, "width" => 20, "height" => 5 }])

            vehicle = Vehicle.find :bicycle

            vehicle.can_deliver?(delivery).should be_true
          end
        end

        context "and it can't fit the product" do
          it "returns false" do
            delivery = double("Delivery")
            delivery.stub(:distance).and_return(Vehicle::VEHICLES[:bicycle][:limit] - 10)
            delivery.stub(:products).and_return([{ "weight" => 4, "length" => 45, "width" => 20, "height" => 5 }])

            vehicle = Vehicle.find :bicycle

            vehicle.can_deliver?(delivery).should be_false
          end
        end
      end

      context "when the delivery distance is more than the limit" do
        it "returns true" do
          delivery = double("Delivery")
          delivery.stub(:distance).and_return(Vehicle::VEHICLES[:bicycle][:limit] + 10)

          vehicle = Vehicle.find :bicycle

          vehicle.can_deliver?(delivery).should be_false
        end
      end
    end
  end

  describe "#find_for_distance" do
    context "when passing a distance" do
      it "returns the vehicle that can do it" do
        vehicle = Vehicle.find_for_distance 10
        vehicle.name.should == :bicycle

        vehicle = Vehicle.find_for_distance 780
        vehicle.name.should == :parcel_car

        vehicle = Vehicle.find_for_distance 6000
        vehicle.name.should == :large_van
      end
    end
  end
end
