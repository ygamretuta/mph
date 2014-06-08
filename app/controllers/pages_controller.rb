class PagesController < ApplicationController
  def index
    if user_signed_in?
      @notifications = current_user.mailbox.notifications.unread
      @successful_transactions = current_user.purchases.successful | current_user.sales.successful
      render template:'pages/dashboard'
    end
  end

  def search
    q = params[:q].present? ? params[:q] : '*'
    where_cons = {status:'active'}

    if params[:category_id]
      where_cons[:category_id] = params[:category_id]
    end

    if params[:ad_type]
      where_cons[:ad_type] = params[:ad_type]
    end

    has_min_price = params.has_key?('min_price')
    has_max_price = params.has_key?('max_price')

    max_price  = has_max_price ? (params[:max_price].to_i * 100) : 0
    min_price = has_min_price ? (params[:min_price].to_i * 100) : 0

    if has_min_price && ! has_max_price
      where_cons[:price_centavos] = {gte:min_price}
    elsif has_max_price && ! has_min_price
      where_cons[:price_centavos] = {lte:max_price}
    elsif has_min_price && has_max_price
      where_cons[:price_centavos] = min_price..max_price
    end

    @items = Item.search(q,
                         operator:'or',
                         page:params[:page],
                         fields:[{name: :word_start}],
                         where:where_cons)
  end
end