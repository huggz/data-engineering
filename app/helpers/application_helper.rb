module ApplicationHelper
  def flash_class(level)
    case level
      when :success then 'alert-success'
      when :error then 'alert-danger'
      when :alert then 'alert-warning'
      else 'alert-info'
    end
  end

  def upload_page?
    params[:controller] == 'uploads'
  end

  def merchant_page?
    params[:controller].in?(%w[merchants merchants/items merchants/items/purchases])
  end
end
