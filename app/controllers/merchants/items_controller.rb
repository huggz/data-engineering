class Merchants::ItemsController < ApplicationController
  PAGE_SIZE = 25.freeze

  before_action :authenticate_user!

  def index
    @items = merchant.items.page(params[:page]).per(PAGE_SIZE)
  end

  private

  def merchant
    @merchant ||= Merchant.find(params[:merchant_id])
  end
end
