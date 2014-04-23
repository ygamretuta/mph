class AddSellerIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :seller_id, :integer
    add_index :transactions, :seller_id
  end
end
