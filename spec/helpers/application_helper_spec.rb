require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#flash_class' do
    it 'returns "alert-success" for :success' do
      expect(helper.flash_class(:success)).to eq 'alert-success'
    end

    it 'returns "alert-danger" for :error' do
      expect(helper.flash_class(:error)).to eq 'alert-danger'
    end

    it 'returns "alert-warning" for :alert' do
      expect(helper.flash_class(:alert)).to eq 'alert-warning'
    end

    it 'returns "alert-info" for :notice' do
      expect(helper.flash_class(:notice)).to eq 'alert-info'
    end

    it 'returns "alert-info" for unexpected values' do
      [:foo, 'bar', 3].each do |value|
        expect(helper.flash_class(value)).to eq 'alert-info'
      end
    end
  end

  describe '#upload_page?' do
    it 'returns true when on an uploads controller page' do
      allow(params).to receive(:[]).with(:controller).and_return('uploads')
      expect(helper).to be_upload_page
    end

    it 'returns false when on any other controller page' do
      allow(params).to receive(:[]).with(:controller).and_return('pages')
      expect(helper).to_not be_upload_page
    end
  end

  describe '#merchant_page?' do
    it 'returns true when on a merchants controller page' do
      allow(params).to receive(:[]).with(:controller).and_return('merchants')
      expect(helper).to be_merchant_page
    end

    it 'returns true when on an items controller page' do
      allow(params).to receive(:[]).with(:controller).and_return('merchants/items')
      expect(helper).to be_merchant_page
    end

    it 'returns true when on a purchases controller page' do
      allow(params).to receive(:[]).with(:controller).and_return('merchants/items/purchases')
      expect(helper).to be_merchant_page
    end

    it 'returns false when on any other controller page' do
      allow(params).to receive(:[]).with(:controller).and_return('pages')
      expect(helper).to_not be_merchant_page
    end
  end
end
