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
#

require 'spec_helper'

describe Transaction do

end
