require 'sinatra'
require 'json'

module GameOfShutl
  class Delivery
    VEHICLES = {
      "bicycle"    =>  1.10,
      "motorbike"  =>  1.15,
      "parcel_car" =>  1.20,
      "small_van"  =>  1.30,
      "large_van"  =>  1.40
    }
  end

  class Server < Sinatra::Base
    post '/quotes' do
      quote = JSON.parse(params['quote'])

      price = ((quote['pickup_postcode'].to_i(36) - quote['delivery_postcode'].to_i(36)) / 1000).abs

      price = price * Delivery::VEHICLES[quote['vehicle']] if quote['vehicle']

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          price: sprintf("%0.02f", price),
          vehicle: (quote['vehicle'] if quote['vehicle'])
        }
      }.to_json
    end
  end
end
