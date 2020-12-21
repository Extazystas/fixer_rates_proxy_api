class ExchangeRate
  include Mongoid::Document

  field :base, type: String
  field :date, type: Date
  field :symbols, type: Array
  field :rates, type: Hash

  validates :base, presence: true
  validates :date, presence: true
  validates :symbols, presence: true
  validates :rates, presence: true

  scope :date, -> (date) { where(date: date) }
  scope :symbols, -> (symbols) { where(symbols: symbols) }

  index({ date: 1 })
end
