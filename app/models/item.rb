# == Schema Information
#
# Table name: items
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  ad_type        :string(255)
#  category_id    :integer
#  user_id        :integer
#  phone          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  description    :text
#  price_centavos :integer          default(0), not null
#  price_currency :string(255)      default("PHP"), not null
#  status         :string(255)
#

class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
  accepts_nested_attributes_for :pictures, allow_destroy:true, reject_if: proc{|a|a['path'].blank?}

  # enumerize
  extend Enumerize
  enumerize :ad_type, in:[:for_sale, :looking_for, :swap], :default => :for_sale
  enumerize :status, in:[:active, :inactive, :sold], :default => :active

  # money_rails
  monetize :price_centavos, allow_nil:true, numericality:{greater_than:0}

  # kaminari
  paginates_per 5

  #searchkick
  searchkick

  validates_presence_of :ad_type, :name
  validates_associated :pictures

  # validates :pictures, length:{minimum:1, maximum: 10}

  scope :available, -> {joins(:transactions).where('transactions.buyer_confirmed IS FALSE OR transactions.seller_confirmed IS FALSE')}

  after_create :decrease_allowed_ads

  def to_s
    self.name
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

  def is_for_sale?
    self.ad_type == 'for_sale'
  end

  def is_for_swap?
    self.ad_type == 'swap'
  end

  def is_looking_for?
    self.ad_type == 'looking_for'
  end

  def can_be_reserved_by?(user)
    ! self.sold? && ! self.is_reserved? && ! self.is_owned_by?(user) && self.is_for_sale?
  end

  def sold?
    self.status == 'sold'
  end

  def active?
    self.status == 'active'
  end

  def inactive?
    self.status == 'inactive'
  end

  private

  def decrease_allowed_ads
    user = self.user
    allowed_ads = user.allowed_ads_today
    if user.allowed_ads_today > 0
      user.update(allowed_ads_today:allowed_ads - 1)
    end
  end
end
