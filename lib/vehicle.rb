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

  def self.find_for_distance distance
    #in a real world application this would probably make a query to a database, something like:
    # in mysql: SELECT * FROM vehicles WHERE distance_limit >= ? ORDER BY distance_limit LIMIT 1;
    # in active record: Vehicle.where("distance_limit >= ?", limit).order(:distance_limit).first

    VEHICLES.each_pair do |name, values|
      return Vehicle.find name if values[:limit].nil? || values[:limit] > distance
    end
  end

  def can_deliver? delivery
    limit >= delivery.distance || limit.nil?
  end

  def to_s
    name.to_s
  end
end
