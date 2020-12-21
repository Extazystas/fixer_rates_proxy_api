class ExchangeRate
  include Mongoid::Document

  field :base, type: String
  field :date, type: Date
  field :rates, type: Hash

  validates :base, presence: true
  validates :date, presence: true
  validates :rates, presence: true

  index({ date: 1 }, { unique: true })
end
