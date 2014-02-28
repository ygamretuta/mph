class PagesController < ApplicationController
  def index
  end

  def search
    q = params[:q]
    @items = Item.search(q).page params[:page]
  end
end
