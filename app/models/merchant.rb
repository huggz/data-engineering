class Merchant < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true

  has_many :items, inverse_of: :merchant, dependent: :destroy
  has_many :purchases, through: :items

  scope :named, ->(name) { where(name: name) }
end
