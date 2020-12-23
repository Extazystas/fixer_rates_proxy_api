require 'spec_helper'

RSpec.describe FixerRatesFetcher do
  let(:base)    { 'EUR' }
  let(:symbols) { ['USD'] }
  let(:date)    { '2020-12-20' }
  let(:good_response_stub) do
    {
      'success': true,
      'timestamp': 1_608_508_799,
      'historical': true,
      'base': 'EUR',
      'date': '2020-12-20',
      'rates': { 'USD' => 1.221575 }
    }
  end
  let(:bad_response_stub) do
    {
      'success': false,
      'error' => { 'code' => 101,
                   'type' => 'invalid_access_key',
                   'info' => 'You have not supplied a valid API Access Key. [Technical Support: support@apilayer.com]' }
    }
  end
  let(:service) { described_class.new(base, date, symbols).call }

  before { allow(Sinatra::Application.settings).to receive(:fixer_api_key).and_return('111') }
  before do
    allow(Sinatra::Application.settings)
      .to receive(:fixer_api_url).and_return('http://data.fixer.io/api')
  end

  context 'good response' do
    before { allow(Faraday).to receive(:get).and_return(double(body: good_response_stub.to_json)) }

    it { expect(service['success']).to be true }

    it { expect(service['base']).to  eq good_response_stub[:base] }
    it { expect(service['date']).to  eq good_response_stub[:date] }
    it { expect(service['rates']).to eq good_response_stub[:rates] }
  end

  context 'bad response' do
    before { allow(Faraday).to receive(:get).and_return(double(body: bad_response_stub.to_json)) }

    it { expect(service['success']).to be false }
    it { expect(service['error']).to be_present }
  end
end
