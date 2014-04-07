class AddConfirmedFieldsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :buyer_confirmed, :boolean, default:false
    add_column :transactions, :seller_confirmed, :boolean, default:false
    add_column :transactions, :cancelled, :boolean, default:false
  end
end
