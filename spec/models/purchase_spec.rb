require 'rails_helper'

RSpec.describe Purchase do
  describe 'attributes' do
    it { should have_attribute :quantity }
  end

  describe 'associations' do
    it { should belong_to :purchaser }
    it { should belong_to :item }
  end

  describe 'validations' do
    before { create :purchase }

    it { should validate_presence_of :purchaser }
    it { should validate_presence_of :item }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1) }
  end

  describe '.with_purchaser' do
    subject { described_class }

    it 'includes the purchaser' do
      expect(subject).to receive(:includes).with(:purchaser)
      subject.with_purchaser
    end
  end

  describe '#total_cost' do
    subject { build :purchase, quantity: 3, item: item }

    let(:item) { build :item, price: 0.49 }

    its(:total_cost) { should eq 1.47 }
  end
end
