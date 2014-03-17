class DropPointers < ActiveRecord::Migration
  def change
    drop_table :pointers
  end
end
