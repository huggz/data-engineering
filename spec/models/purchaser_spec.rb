require 'rails_helper'

RSpec.describe Purchaser do
  describe 'attributes' do
    it { should have_attribute :name }
  end

  describe 'associations' do
    it { should have_many(:purchases).dependent(:destroy) }
    it { should have_many(:items).through(:purchases) }
  end

  describe 'validations' do
    before { create :purchaser }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '.named' do
    subject { described_class }

    let!(:purchaser) { create :purchaser }
    let!(:other_purchasers) { create_list :purchaser, 2 }

    it 'finds purchasers with the provided name' do
      expect(subject.named(purchaser.name)).to eq [purchaser]
    end
  end
end
