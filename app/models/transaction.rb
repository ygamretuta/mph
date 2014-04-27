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
#  seller_id        :integer
#

class Transaction < ActiveRecord::Base
  belongs_to :buyer, class_name:'User', foreign_key: :buyer_id
  belongs_to :seller, class_name:'User', foreign_key: :seller_id
  belongs_to :item

  #attr_readonly :buyer
  #attr_readonly :seller

  after_save :mark_as_sold_if_successful
  after_create :notify_poster

  #validates_timeliness
  validates_date :transaction_date, :on_or_after => Date.today

  # for use for querying from item
  scope :successful, -> { where(buyer_confirmed:true).where(seller_confirmed:true) }

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

  def mark_as_sold_if_successful
    if self.successful?
      self.item.update(status:'sold')
    end
  end

  def notify_poster
    if self.item.is_for_sale?
      self.seller.notify('Item Reservation', "#{self.buyer.username} has reserved your #{self.item.name}")
    elsif self.item.is_for_swap?
      self.buyer.notify('Swap Proposal', "#{self.buyer.username} has proposed a swap for your #{self.item.name}")
    elsif self.item.is_looking_for?
      self.buyer.notify('Item Offer', "#{self.buyer.username} has offered you a #{self.item.name}")
    end
  end
end
