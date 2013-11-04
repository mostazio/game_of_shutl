require 'spec_helper'

describe 'Basic Service' do
  let(:request) do
    {
      quote: {
        pickup_postcode:   'SW1A 1AA',
        delivery_postcode: 'EC2A 3LT',
        products: [
          {
            weight: 10,
            width: 50,
            height: 50,
            length: 50
          }
        ]
      }.to_json
    }
  end

  it 'selects the most suitable vehicle' do
    post '/quotes', request

    last_response.should be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['price']).to eql "814.80"
    expect(quote['vehicle']).to eql 'parcel_car'
  end
end
