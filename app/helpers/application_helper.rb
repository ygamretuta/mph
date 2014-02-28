module ApplicationHelper
  def search_value
    params[:q].present? ? params[:q] : nil
  end

  def price_precision(price)
    if price.is_a?(BigDecimal)
      (price.round == price) ? 0 : 2
    else
      return nil
    end
  end
end
