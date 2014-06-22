require 'rails_helper'

RSpec.describe UploadsController do
  describe 'GET new' do
    it_behaves_like 'an authenticated page' do
      before { get :new }
    end

    describe 'as an authenticated user' do
      before do
        sign_in user
        get :new
      end

      let(:user) { create :user }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'passes an upload object to the view' do
        expect(assigns[:upload]).to be_an Upload
      end

      it 'renders the new view' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST create' do
    it_behaves_like 'an authenticated page' do
      before { post :create }
    end

    describe 'as an authenticated user' do
      before do
        sign_in user
        post :create, upload: { file: file }
      end

      let(:user) { create :user }
      let(:file) { fixture_file(filename, Mime::CSV.to_s) }

      describe 'with a valid form submission' do
        let(:filename) { 'imports/sample1.csv' }

        it 'redirects to the merchants page' do
          expect(response).to redirect_to merchants_path
        end

        it 'displays a notice to the user' do
          expect(flash[:notice]).to eq 'Your file has been uploaded with a gross revenue totalling $95.00.'
        end
      end

      describe 'with an invalid form submission' do
        let(:filename) { 'imports/invalid.csv' }

        it 'responds successfully' do
          expect(response).to be_success
        end

        it 'passes an upload object to the view' do
          expect(assigns[:upload]).to be_an Upload
        end

        it 'renders the new view' do
          expect(response).to render_template :new
        end

        it 'displays a notice to the user' do
          expect(flash.now[:error]).to eq 'An error occurred while trying to upload your file.'
        end
      end
    end
  end
end
