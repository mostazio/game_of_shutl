require 'spec_helper'

describe 'Variable pricing by vehicle' do
  it 'changes the price based upon the vehicle' do
    request =  {
      quote: {
        pickup_postcode:   'SW1A 1AA',
        delivery_postcode: 'EC2A 3LT',
        vehicle:           'bicycle'
      }.to_json
    }

    post '/quotes', request
    quote = JSON.parse(last_response.body)['quote']

    expect(quote['price']).to eql "780.85"
    expect(quote['vehicle']).to eql "motorbike"

    request =  {
      quote: {
        pickup_postcode:   'SW1A 1AA',
        delivery_postcode: 'EC2A 3LT',
        vehicle:           'small_van'
      }.to_json
    }

    post '/quotes', request
    quote = JSON.parse(last_response.body)['quote']

    expect(quote['price']).to eql "882.70"
    expect(quote['vehicle']).to eql "small_van"
  end
end
