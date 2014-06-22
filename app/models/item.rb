class Item < ActiveRecord::Base
  validates :merchant, presence: true
  validates :description, presence: true, uniqueness: { scope: :merchant_id }
  validates :price, presence: true, numericality: { greater_than: 0 }

  belongs_to :merchant, inverse_of: :items
  has_many :purchases, inverse_of: :item, dependent: :destroy

  scope :with_merchant, -> { includes(:merchant) }
  scope :for_merchant, ->(merchant_id) { where(merchant_id: merchant_id) }
  scope :described_as, ->(description) { where(description: description) }
end
