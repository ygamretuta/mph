# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  ad_type     :string(255)
#  description :text
#  category_id :integer
#  user_id     :integer
#  price       :decimal(, )
#  phone       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :pictures
  accepts_nested_attributes_for :pictures, allow_destroy:true, reject_if: proc{|a|a['path'].blank?}

  # enumerize gem declarations
  extend Enumerize
  enumerize :ad_type, in:[:for_sale, :looking_for, :swap], :default => :for_sale

  validates_presence_of :ad_type, :name
  validates_associated :category
  validates :pictures, length:{minimum:1, maximum: 10}

  def to_s
    self.name
  end
end
