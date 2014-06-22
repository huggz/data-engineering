require 'rails_helper'

RSpec.describe Merchant do
  describe 'attributes' do
    it { should have_attribute :name }
    it { should have_attribute :address }
  end

  describe 'associations' do
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:purchases).through(:items) }
  end

  describe 'validations' do
    before { create :merchant }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :address }
  end

  describe '.named' do
    subject { described_class }

    let!(:merchant) { create :merchant }
    let!(:other_merchants) { create_list :merchant, 2 }

    it 'finds merchants with the provided name' do
      expect(subject.named(merchant.name)).to eq [merchant]
    end
  end
end
