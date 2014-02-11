# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  path       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'file_size_validator'

class Picture < ActiveRecord::Base
  belongs_to :item
  mount_uploader :path, PictureUploader
  validates_associated :item
  validates :path, file_size:{maximum:1.megabytes.to_i}
end