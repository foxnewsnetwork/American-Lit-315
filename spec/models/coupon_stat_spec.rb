# == Schema Information
#
# Table name: coupon_stats
#
#  id           :integer(4)      not null, primary key
#  coupon_id    :integer(4)
#  user_id      :integer(4)
#  interactions :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe CouponStat do
  pending "add some examples to (or delete) #{__FILE__}"
end
