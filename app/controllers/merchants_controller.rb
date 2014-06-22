class MerchantsController < ApplicationController
  PAGE_SIZE = 25.freeze

  before_action :authenticate_user!

  def index
    @merchants = Merchant.page(params[:page]).per(PAGE_SIZE)
  end
end
