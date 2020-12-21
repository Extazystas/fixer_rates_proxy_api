require 'spec_helper'

RSpec.describe ExchangeRate do
  let(:rate) do
    ExchangeRate.create(
      base: 'EUR',
      date: '2019-12-13',
      symbols: %w[GBP USD],
      rates: { GBP: 0.892047, USD: 1.23396 }
    )
  end

  context 'serialize rate object' do
    it do
      expect(ExchangeRateSerializer.new(rate).as_json).to eq(
        {
          base: rate.base,
          date: rate.date,
          symbols: rate.symbols,
          rates: rate.rates
        }
      )
    end
  end
end
