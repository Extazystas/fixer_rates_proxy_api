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

  scope :base,    ->(b) { where(base: b) }
  scope :date,    ->(d) { where(date: d) }
  scope :symbols, ->(s) { where(symbols: s) }

  index({ date: 1 })
end
