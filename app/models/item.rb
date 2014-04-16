# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  ad_type     :string(255)
#  category_id :integer
#  user_id     :integer
#  price       :decimal(, )
#  phone       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
  accepts_nested_attributes_for :pictures, allow_destroy:true, reject_if: proc{|a|a['path'].blank?}

  # enumerize gem declarations
  extend Enumerize
  enumerize :ad_type, in:[:for_sale, :looking_for, :swap], :default => :for_sale

  # kaminari declarations
  paginates_per 5

  validates_presence_of :ad_type, :name
  validates_associated :pictures
  validates_numericality_of :price, :greater_than => 0, allow_blank:true, allow_nil:true

  # validates :pictures, length:{minimum:1, maximum: 10}

  scope :available, -> {joins(:transactions).where('transactions.buyer_confirmed IS FALSE OR transactions.seller_confirmed IS FALSE')}

  def to_s
    self.name
  end

  def self.search(q)
    keywords = q.split(" ").map{|kw| '%' + kw + '%'}
    self.where{name.like_any keywords}
  end

  def is_owned_by?(user)
    self.user == user
  end

  def is_reserved_by?(user)
    !!self.transactions.where('buyer_id=?', user.id).exists?
  end
  
  def is_reserved?
    self.transactions.any?
  end

  def sold?
    self.transactions.successful.any?
  end

  def can_be_reserved_by?(user)
    ! self.sold? && ! self.is_reserved? && ! self.is_owned_by?(user)
  end
end
