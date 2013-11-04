require 'sinatra'
require 'json'

module GameOfShutl
  class Server < Sinatra::Base
    post '/quotes' do
      quote = JSON.parse(params['quote'])

      delivery = Delivery.new(quote)

      delivery.to_json
    end
  end
end
