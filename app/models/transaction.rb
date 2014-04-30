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
  scope :successful, -> {where('buyer_confirmed IS TRUE AND seller_confirmed IS TRUE')}
  scope :pending, -> {where('buyer_confirmed IS FALSE OR seller_confirmed IS FALSE')}

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
    buyer = self.buyer
    seller = self.seller
    item = self.item

    if item.is_for_sale?
      seller.notify('Item Reservation', "#{buyer.username} has reserved your #{item.name}")
    elsif item.is_for_swap?
      buyer.notify('Swap Proposal', "#{buyer.username} has proposed a swap for your #{item.name}")
    elsif item.is_looking_for?
      buyer.notify('Item Offer', "#{buyer.username} has offered you a #{item.name}")
    end
  end
end
