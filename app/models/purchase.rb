class Purchase < ActiveRecord::Base
  validates :purchaser, presence: true
  validates :item, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  belongs_to :purchaser, inverse_of: :purchases
  belongs_to :item, inverse_of: :purchases

  scope :with_purchaser, -> { includes(:purchaser) }

  def total_cost
    item.price * quantity
  end
end
