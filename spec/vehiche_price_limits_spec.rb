require 'spec_helper'

describe "vehicle price limits" do
  let(:request) do
    {
      quote: {
        pickup_postcode:   'SW1A 1AA',
        delivery_postcode: 'EC2A 3LT'
      }.to_json
    }
  end


  context "when no vehicle is specified in the quote" do
    it 'selects the first vehicle that supports the given distance' do
      post '/quotes', request

      last_response.should be_ok

      quote = JSON.parse(last_response.body)['quote']

      expect(quote['pickup_postcode']).to eql "SW1A 1AA"
      expect(quote['delivery_postcode']).to eql "EC2A 3LT"
      expect(quote['price']).to eql '780.85'
      expect(quote['vehicle']).to eql 'motorbike'
    end
  end
end
