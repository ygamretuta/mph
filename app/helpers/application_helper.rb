module ApplicationHelper
  def search_value
    params[:q].present? ? params[:q] : nil
  end

  def price_precision(price)
    (price.round == price) ? 0 : 2
  end
end
