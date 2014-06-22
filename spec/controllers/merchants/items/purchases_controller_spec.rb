require 'rails_helper'

RSpec.describe Merchants::Items::PurchasesController do
  describe 'GET index' do
    let(:item) { create :item }

    it_behaves_like 'an authenticated page' do
      before { get :index, merchant_id: item.merchant.to_param, item_id: item.to_param }
    end

    describe 'as an authenticated user' do
      before do
        sign_in user
        stub_const("#{described_class}::PAGE_SIZE", page_size)
        create_list :purchase, page_size + 1, item: item
        get :index, merchant_id: item.merchant.to_param, item_id: item.to_param
      end

      let(:user) { create :user }
      let(:page_size) { 2 }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'assigns purchases belonging to this item' do
        expect(assigns[:purchases].to_a).to be_an_array_of Purchase
        expect(assigns[:purchases].map(&:item).uniq).to eq [item]
      end

      it 'paginates items' do
        expect(assigns[:purchases]).to respond_to :current_page
        expect(assigns[:purchases]).to respond_to :total_pages
        expect(assigns[:purchases]).to have(page_size).items
      end
    end
  end
end
