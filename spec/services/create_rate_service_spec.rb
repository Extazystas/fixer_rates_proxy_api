require 'spec_helper'

RSpec.describe CreateRateService do
  context 'valid params' do
    let(:service) { described_class.new(params).call }
    let(:params) do
      {
        'success': true,
        'timestamp': 1_608_508_799,
        'historical': true,
        'base': 'EUR',
        'date': '2020-12-20',
        'rates': { 'USD' => 1.221575 }
      }
    end

    it { expect(service.valid?).to be true }

    it { expect(service.base).to eq 'EUR' }
    it { expect(service.date.to_s).to eq '2020-12-20' }
    it { expect(service.symbols).to eq ['USD'] }
    it { expect(service.rates).to eq({ 'USD' => 1.221575 }) }
  end

  context 'invalid params' do
    let(:service) { described_class.new(params) }
    let(:params) do
      {
        'success': true,
        'timestamp': 1_608_508_799,
        'historical': true,
        'base': '',
        'date': '2020-12-20',
        'rates': { 'USD' => 1.221575 }
      }
    end

    it { expect { service.call }.to raise_error(Mongoid::Errors::Validations) }
  end
end
