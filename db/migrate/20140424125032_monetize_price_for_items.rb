class MonetizePriceForItems < ActiveRecord::Migration
  def change
    remove_column :items, :price
    add_money :items, :price
  end
end
