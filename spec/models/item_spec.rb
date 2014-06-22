require 'rails_helper'

RSpec.describe Item do
  describe 'attributes' do
    it { should have_attribute :description }
    it { should have_attribute :price }
  end

  describe 'associations' do
    it { should belong_to :merchant }
    it { should have_many(:purchases).dependent(:destroy) }
  end

  describe 'validations' do
    before { create :item }

    it { should validate_presence_of :merchant }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_uniqueness_of(:description).scoped_to(:merchant_id) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe '.with_merchant' do
    subject { described_class }

    it 'includes the merchant' do
      expect(subject).to receive(:includes).with(:merchant)
      subject.with_merchant
    end
  end

  describe '.for_merchant' do
    subject { described_class }

    let!(:merchant) { create :merchant, :with_items }
    let!(:other_merchant) { create :merchant, :with_items }

    it 'finds items belonging to the provided merchant' do
      expect(subject.for_merchant(merchant.id).map(&:merchant_id).uniq).to eq [merchant.id]
    end
  end

  describe '.described_as' do
    subject { described_class }

    let!(:item) { create :item }
    let!(:other_items) { create_list :item, 2 }

    it 'finds items with the provided description' do
      expect(subject.described_as(item.description)).to eq [item]
    end
  end
end
