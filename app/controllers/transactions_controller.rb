class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :buyer_confirm, :seller_confirm]
  before_action :check_if_can_be_reserved, only: [:new, :create]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = current_user.purchases | current_user.sales
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to user_transactions_path(current_user), notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to user_transactions_url(current_user) }
      format.json { head :no_content }
    end
  end

  # GET '/purchases'
  # GET '/purchases.json'
  def purchases
    @transactions = current_user.purchases.load
    render :action => :index, :transactions => @transactions
  end

  # GET '/sales'
  # GET '/sales.json'
  def sales
    @transactions = current_user.sales.load
    render :action => :index, :transactions => @transactions
  end

  # PUT '/seller_confirm'
  def seller_confirm
    respond_to do |format|
      if @transaction.seller == current_user
        unless @transaction.seller_confirmed?
          @transaction.update(seller_confirmed:true)
        end
        flash[:notice] = confirm_transaction_message(@transaction)
      end
      format.html{redirect_to user_transactions_url(current_user)}
    end
  end

  # PUT '/buyer_confirm'
  def buyer_confirm
    respond_to do |format|
      if @transaction.buyer == current_user
        unless @transaction.buyer_confirmed?
          @transaction.update(buyer_confirmed:true)
        end
        flash[:notice] = confirm_transaction_message(@transaction)
      end
      format.html{redirect_to user_transactions_url(current_user)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:buyer_id, :item_id, :seller_id, :transaction_date)
    end

  def check_if_can_be_reserved
    @item = Item.find(params[:item_id])
    if @item.is_for_sale? &&  ! @item.can_be_reserved_by?(current_user)
      respond_to do |format|
        format.html{redirect_to root_path}
      end
    end
  end
end
