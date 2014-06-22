require 'rails_helper'

RSpec.describe Merchants::ItemsController do
  describe 'GET index' do
    let(:merchant) { create :merchant }

    it_behaves_like 'an authenticated page' do
      before { get :index, merchant_id: merchant.to_param }
    end

    describe 'as an authenticated user' do
      before do
        sign_in user
        stub_const("#{described_class}::PAGE_SIZE", page_size)
        create_list :item, page_size + 1, merchant: merchant
        get :index, merchant_id: merchant.to_param
      end

      let(:user) { create :user }
      let(:page_size) { 2 }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'assigns items belonging to this merchant' do
        expect(assigns[:items].to_a).to be_an_array_of Item
        expect(assigns[:items].map(&:merchant).uniq).to eq [merchant]
      end

      it 'paginates items' do
        expect(assigns[:items]).to respond_to :current_page
        expect(assigns[:items]).to respond_to :total_pages
        expect(assigns[:items]).to have(page_size).items
      end
    end
  end
end
