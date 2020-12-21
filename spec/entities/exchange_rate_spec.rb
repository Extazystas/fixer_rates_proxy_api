require 'spec_helper'

RSpec.describe ExchangeRate, type: :model do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:base).of_type(String) }
  it { is_expected.to have_field(:date).of_type(Date) }
  it { is_expected.to have_field(:rates).of_type(Hash) }

  it { is_expected.to validate_presence_of(:base) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:rates) }

  it { is_expected.to have_index_for(date: 1) }
end
