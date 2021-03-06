class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except:[:index]
  before_action :check_if_owner, only:[:edit, :update]
  # before_action :check_if_can_post, only:[:new, :create]

  # GET /items
  # GET /items.json
  def index
    if params[:user_id].present?
      @items = current_user.items.page params[:page]
    else
      @items = Item.available.page params[:page]
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.pictures.build
    respond_with @item
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.create(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to [current_user, @item], notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        @item.pictures.build
        format.html { render action: 'new', :locals => {item:@item} }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to user_item_path(current_user, @item), notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to user_items_url(current_user) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :ad_type, :description, :category_id, :price, :phone,
                                   :pictures_attributes => [:item_id, :path, :id, :_destroy])
    end

    def check_if_owner
      unless @item.is_owned_by?(current_user)
        redirect_to root_path, alert:'You are not allowed to modify this ad.'
      end
    end

    def check_if_can_post
      unless current_user.allowed_ads_today > 0
        redirect_to root_path, alert:'You are only allowed to post 2 ads each day.'
      end
    end
end
