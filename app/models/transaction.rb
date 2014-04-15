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

  after_save :assign_points_if_successful

  scope :sales, ->(user){includes(:item).where('items.user_id = ?', user.id).references(:item)}
  scope :purchases, ->(user){where(buyer:user)}

  # for use for querying from item
  scope :successful, -> { where(buyer_confirmed:true).where(seller_confirmed:true) }

  def seller
    item.user
  end

  # for use with instance
  def successful?
    self.buyer_confirmed? && self.seller_confirmed?
  end

  def self.cleanup
  	Transaction.where("created_at < ?", 30.days.ago).where('buyer_confirmed IS NOT TRUE').destroy_all
  end

  def awaiting_confirmation?
  	self.buyer_confirmed || self.seller_confirmed?
  end

  private

  def assign_points_if_successful
    if self.successful?
      self.seller.add_points(10)
      self.buyer.add_points(10)
    end
  end
end