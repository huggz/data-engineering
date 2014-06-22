class UploadsController < ApplicationController
  before_action :authenticate_user!

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      revenue = ActiveSupport::NumberHelper.number_to_currency(@upload.revenue)
      redirect_to merchants_path, notice: t('upload.message.success', revenue: revenue)
    else
      flash.now[:error] = t('upload.message.error')
      render :new
    end
  end

  private

  def upload_params
    params.fetch(:upload, {}).permit(:file)
  end
end
