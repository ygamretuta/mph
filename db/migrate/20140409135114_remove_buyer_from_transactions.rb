class RemoveBuyerFromTransactions < ActiveRecord::Migration
  def self.up
    remove_column :transactions, :seller_id
  end

  def self.down
    add_column :transactions, :seller_id, :integer
    add_index :transactions, :seller_id
  end
end
