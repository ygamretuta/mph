class PagesController < ApplicationController
  def index
    if user_signed_in?
      @notifications = current_user.mailbox.notifications
      @successful_transactions = current_user.purchases.successful | current_user.sales.successful
      render template:'pages/dashboard'
    end
  end

  def search
    q = params[:q]
    @items = Item.search(q, operator:'or', page:params[:page], fields:[{name: :word_start}])
  end
end
