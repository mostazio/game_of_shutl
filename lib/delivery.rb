class Delivery
  ACCEPTED_PARAMETERS = [
    :pickup_postcode,
    :delivery_postcode,
    :vehicle,
    :products
  ]

  attr_reader *ACCEPTED_PARAMETERS

  def initialize properties
    properties.each do |k,v|
    instance_variable_set "@#{k}", v if ACCEPTED_PARAMETERS.include? k.to_sym
    end if properties.is_a? Hash

    @vehicle = Vehicle.find vehicle if vehicle

    @vehicle = Vehicle.find_for_delivery(self) unless @vehicle && @vehicle.can_deliver?(self)
  end

  def distance
    ((pickup_postcode.to_i(36) - delivery_postcode.to_i(36)) / 1000).abs
  end

  def price
    @price = distance
    @price = @price * vehicle.value if vehicle

    @price
  end

  def format_price
    (price.is_a? Fixnum) ? price : sprintf("%0.02f", price)
  end

  def to_json
    {
      quote: {
        pickup_postcode: pickup_postcode,
        delivery_postcode: delivery_postcode,
        price: format_price,
        vehicle: (vehicle ? vehicle : nil)
      }.select{|k,v| v}
    }.to_json
  end
end
