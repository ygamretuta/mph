# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  seller_id        :integer
#  buyer_id         :integer
#  item_id          :integer
#  transaction_date :date
#  created_at       :datetime
#  updated_at       :datetime
#  buyer_confirmed  :boolean          default(FALSE)
#  seller_confirmed :boolean          default(FALSE)
#  cancelled        :boolean          default(FALSE)
#

class Transaction < ActiveRecord::Base
  belongs_to :seller, class_name:'User', foreign_key: :seller_id
  belongs_to :buyer, class_name:'User', foreign_key: :buyer_id
  belongs_to :item

  def successful?
    self.buyer_confirmed? && self.seller_confirmed?
  end
end
