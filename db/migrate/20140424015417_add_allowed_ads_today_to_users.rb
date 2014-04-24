class AddAllowedAdsTodayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allowed_ads_today, :integer, default:2
  end
end