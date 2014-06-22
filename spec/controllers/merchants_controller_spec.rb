require 'rails_helper'

RSpec.describe MerchantsController do
  describe 'GET index' do
    it_behaves_like 'an authenticated page' do
      before { get :index }
    end

    describe 'as an authenticated user' do
      before do
        sign_in user
        stub_const("#{described_class}::PAGE_SIZE", page_size)
        create_list :merchant, page_size + 1
        get :index
      end

      let(:user) { create :user }
      let(:page_size) { 2 }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'assigns merchants' do
        expect(assigns[:merchants].to_a).to be_an_array_of Merchant
      end

      it 'paginates merchants' do
        expect(assigns[:merchants]).to respond_to :current_page
        expect(assigns[:merchants]).to respond_to :total_pages
        expect(assigns[:merchants]).to have(page_size).items
      end
    end
  end
end
