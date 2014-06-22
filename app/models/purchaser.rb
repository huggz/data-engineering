class Purchaser < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :purchases, inverse_of: :purchaser, dependent: :destroy
  has_many :items, through: :purchases

  scope :named, ->(name) { where(name: name) }
end
