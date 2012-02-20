class CouponStat < ActiveRecord::Base
	belongs_to :coupon
	belongs_to :user
end

# == Schema Information
#
# Table name: coupon_stats
#
#  id         :integer(4)      not null, primary key
#  coupon_id  :integer(4)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  game_id    :integer(4)
#

