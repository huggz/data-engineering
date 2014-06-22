require 'rails_helper'

RSpec.describe Importer do
  subject { described_class.new(filename) }

  let(:filename) { Rails.root.join('spec', 'fixtures', 'imports', 'sample1.csv') }

  describe '#filename' do
    its(:filename) { should eq filename }
  end

  describe '#process' do
    it 'creates the correct number of merchants' do
      expect { subject.process }.to change { Merchant.count }.by(3)
    end

    it 'creates the correct number of items' do
      expect { subject.process }.to change { Item.count }.by(3)
    end

    it 'creates the correct number of purchasers' do
      expect { subject.process }.to change { Purchaser.count }.by(3)
    end

    it 'creates the correct number of purchases' do
      expect { subject.process }.to change { Purchase.count }.by(4)
    end

    it 'creates the correct merchants' do
      subject.process
      expect(Merchant.where(name: "Bob's Pizza", address: '987 Fake St')).to have(1).item
      expect(Merchant.where(name: "Tom's Awesome Shop", address: '456 Unreal Rd')).to have(1).item
      expect(Merchant.where(name: 'Sneaker Store Emporium', address: '123 Fake St')).to have(1).item
    end

    it 'creates the correct items' do
      subject.process
      expect(Item.joins(:merchant).where(description: '$10 off $20 of food', price: 10.0, merchants: { name: "Bob's Pizza" })).to have(1).item
      expect(Item.joins(:merchant).where(description: '$30 of awesome for $10', price: 10.0, merchants: { name: "Tom's Awesome Shop" })).to have(1).item
      expect(Item.joins(:merchant).where(description: '$20 Sneakers for $5', price: 5.0, merchants: { name: 'Sneaker Store Emporium' })).to have(1).item
    end

    it 'creates the correct purchasers' do
      subject.process
      expect(Purchaser.where(name: 'Snake Plissken')).to have(1).item
      expect(Purchaser.where(name: 'Amy Pond')).to have(1).item
      expect(Purchaser.where(name: 'Marty McFly')).to have(1).item
    end

    it 'creates the correct purchases' do
      subject.process
      expect(Purchase.joins(:purchaser, :item).where(purchasers: { name: 'Snake Plissken' }, items: { description: '$10 off $20 of food' })).to have(1).item
      expect(Purchase.joins(:purchaser, :item).where(purchasers: { name: 'Amy Pond' }, items: { description: '$30 of awesome for $10' })).to have(1).item
      expect(Purchase.joins(:purchaser, :item).where(purchasers: { name: 'Marty McFly' }, items: { description: '$20 Sneakers for $5' })).to have(1).item
      expect(Purchase.joins(:purchaser, :item).where(purchasers: { name: 'Snake Plissken' }, items: { description: '$20 Sneakers for $5' })).to have(1).item
    end

    it 'returns the total gross revenue' do
      expect(subject.process).to eq 95.0
    end
  end
end
