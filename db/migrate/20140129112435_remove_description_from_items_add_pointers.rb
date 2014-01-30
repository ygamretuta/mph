class RemoveDescriptionFromItemsAddPointers < ActiveRecord::Migration
  def change
    remove_column :items, :description

    create_table :pointers do |t|
      t.string :value
      t.references :item
      t.timestamps
    end
  end
end
