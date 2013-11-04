class Vehicle
  VEHICLES = {
    bicycle: {
      value: 1.10,
      limit: 500,
      weight: 3,
      length: 30,
      width: 25,
      height: 10
    },
    motorbike: {
      value: 1.15,
      limit: 750,
      weight: 6,
      length: 35,
      width: 25,
      height: 25
    },
    parcel_car: {
      value: 1.20,
      limit: 1000,
      weight: 50,
      length: 100,
      width: 100,
      height: 75
    },
    small_van: {
      value: 1.30,
      limit: 1500,
      weight: 400,
      length: 133,
      width: 133,
      height: 133
    },
    large_van: {
      value: 1.40,
      limit: nil,
      weight: nil,
      length: nil,
      width: nil,
      height: nil
    }
  }

  attr_reader :name, :value, :limit, :weight, :length, :width, :height

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

  def self.find_for_delivery delivery
    VEHICLES.keys.each do |name|
      vehicle = Vehicle.find name

      return vehicle if vehicle.can_deliver?(delivery)
    end
  end

  def can_deliver? delivery
    (limit >= delivery.distance || limit.nil?) &&
    can_lift?(delivery) &&
    can_fit?(delivery)
  end

  def can_lift? delivery
    return true unless delivery.products

    weight >= delivery.products.first["weight"] || weight.nil?
  end

  def can_fit? delivery
    return true unless delivery.products

    product_sizes = delivery.products.first.values_at("length", "width", "height").sort.reverse
    vehicle_sizes = [length, width, height].sort.reverse

    vehicle_sizes.each_with_index do |v, i|
      return false if (v - product_sizes[i] < 0)
    end

    return true
  end

  def to_s
    name.to_s
  end
end
