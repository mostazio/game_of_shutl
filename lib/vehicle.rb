class Vehicle
  VEHICLES = {
    bicycle: {
      value: 1.10,
      limit: 500
    },
    motorbike: {
      value: 1.15,
      limit: 750
    },
    parcel_car: {
      value: 1.20,
      limit: 1000
    },
    small_van: {
      value: 1.30,
      limit: 1500
    },
    large_van: {
      value: 1.40,
      limit: nil
    }
  }

  attr_reader :name, :value, :limit

  def initialize params
    params.each do |k,v|
      instance_variable_set "@#{k}", v
    end
  end

  def self.find vehicle_name
    vehicle = VEHICLES[vehicle_name.to_sym] if vehicle_name

    return nil unless vehicle

    Vehicle.new(vehicle.merge(name: vehicle_name))
  end

  def to_s
    name
  end
end
