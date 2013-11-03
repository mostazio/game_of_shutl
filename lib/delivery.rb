class Delivery
  VEHICLES = {
    "bicycle"    =>  1.10,
    "motorbike"  =>  1.15,
    "parcel_car" =>  1.20,
    "small_van"  =>  1.30,
    "large_van"  =>  1.40
  }

  ACCEPTED_PARAMETERS = [
    :pickup_postcode,
    :delivery_postcode,
    :vehicle
  ]

  attr_reader *ACCEPTED_PARAMETERS

  def initialize properties
    properties.each do |k,v|
    instance_variable_set "@#{k}", v if ACCEPTED_PARAMETERS.include? k.to_sym
    end if properties.is_a? Hash
  end

  def price
    @price = ((pickup_postcode.to_i(36) - delivery_postcode.to_i(36)) / 1000).abs
    @price = @price * VEHICLES[vehicle] if vehicle

    @price
  end

  def format_price
    (price.is_a? Fixnum) ? price : sprintf("%0.02f", price)
  end

  def to_s
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
