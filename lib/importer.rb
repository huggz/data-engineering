require 'csv'

class Importer
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def process
    revenue = 0.0

    CSV.foreach(filename, headers: true, col_sep: "\t") do |row|
      merchant = Merchant.named(row['merchant name']).first_or_create(address: row['merchant address'])
      purchaser = Purchaser.named(row['purchaser name']).first_or_create
      item = merchant.items.described_as(row['item description']).first_or_create(price: row['item price'])
      purchase = item.purchases.create(purchaser: purchaser, quantity: row['purchase count'])

      revenue += purchase.total_cost
    end

    revenue
  end
end
