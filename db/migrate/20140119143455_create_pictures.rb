class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :item, index: true
      t.string :path

      t.timestamps
    end
  end
end
