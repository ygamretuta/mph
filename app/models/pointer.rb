# == Schema Information
#
# Table name: pointers
#
#  id         :integer          not null, primary key
#  value      :string(255)
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Pointer < ActiveRecord::Base
  belongs_to :item

  validates :value, length:{minimum:10, maximum:100}
end
