require 'json'

module GameOfShutl
  class Server < Sinatra::Base
    post '/quotes' do
      quote = JSON.parse(params['quote'])

      {
        quote: {
          pickup_postcode: quote['pickup_postcode'],
          delivery_postcode: quote['delivery_postcode'],
          price: 679
        }
      }.to_json
    end
  end
end