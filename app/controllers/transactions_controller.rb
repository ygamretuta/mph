class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :buyer_confirm, :seller_confirm]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = current_user.purchase_transactions.to_a + current_user.sales_transactions.to_a
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
    @transactions = current_user.purchase_transactions.load
    render :action => :index, :transactions => @transactions
  end

  # GET '/sales'
  # GET '/sales.json'
  def sales
    @transactions = current_user.sales_transactions.load
    render :action => :index, :transactions => @transactions
  end

  def seller_confirm
    respond_to do |format|
      if @transaction.seller == current_user
        @transaction.update(seller_confirmed:true)
        flash[:notice] = confirm_transaction_message(@transaction)
      end
      format.html{redirect_to user_transactions_url(current_user)}
    end
  end

  def buyer_confirm
    respond_to do |format|
      if @transaction.buyer == current_user
        @transaction.update(buyer_confirmed:true)
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
      params.require(:transaction).permit(:seller_id, :buyer_id, :item_id, :transaction_date)
    end
end
