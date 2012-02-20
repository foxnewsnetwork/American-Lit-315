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

class CouponStat < ActiveRecord::Base
	belongs_to :coupon
	belongs_to :user

	def redeem
		self.interactions ||= 0
		self.interactions += 1
		self.save!
	end
end
