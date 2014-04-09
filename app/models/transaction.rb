# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  item_id          :integer
#  transaction_date :date
#  created_at       :datetime
#  updated_at       :datetime
#  buyer_confirmed  :boolean          default(FALSE)
#  seller_confirmed :boolean          default(FALSE)
#  cancelled        :boolean          default(FALSE)
#  buyer_id         :integer
#

class Transaction < ActiveRecord::Base
  belongs_to :buyer, class_name:'User', foreign_key: :buyer_id
  belongs_to :item

  attr_readonly :buyer

  scope :sales, ->(user){includes(:item).where('items.user_id = ?', user.id).references(:item)}
  scope :purchases, ->(user){where(buyer:user)}
  scope :all_user_transactions, ->(user){sales(user).purchases(user)}

  def seller
    item.user
  end

  def successful?
    self.buyer_confirmed? && self.seller_confirmed?
  end

  def self.cleanup
  	Transaction.where("created_at < ?", 30.days.ago).destroy_all
  end

  def awaiting_confirmation?
  	self.buyer_confirmed || self.seller_confirmed?
  end
end
