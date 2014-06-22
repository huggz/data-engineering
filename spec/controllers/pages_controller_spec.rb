require 'rails_helper'

RSpec.describe PagesController do
  describe 'GET home' do
    before { get :home }

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'renders the home view' do
      expect(response).to render_template :home
    end
  end
end
