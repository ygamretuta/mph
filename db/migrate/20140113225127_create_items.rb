class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :ad_type
      t.text :description
      t.references :category, index: true
      t.references :user, index:true
      t.decimal :price
      t.string :phone
      t.string :photo

      t.timestamps
    end
  end
end
