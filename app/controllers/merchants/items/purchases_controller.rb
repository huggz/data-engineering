class Merchants::Items::PurchasesController < ApplicationController
  PAGE_SIZE = 25.freeze

  before_action :authenticate_user!

  def index
    @purchases = item.purchases.with_purchaser.page(params[:page]).per(PAGE_SIZE)
  end

  private

  def item
    @item ||= Item.with_merchant.for_merchant(params[:merchant_id]).find(params[:item_id])
  end
end
