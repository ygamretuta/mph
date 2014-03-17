class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :seller, index: true
      t.references :buyer, index: true
      t.references :item, index: true
      t.date :transaction_date

      t.timestamps
    end
  end
end
