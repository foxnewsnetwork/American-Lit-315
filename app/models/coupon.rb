# == Schema Information
#
# Table name: coupons
#
#  id         :integer(4)      not null, primary key
#  company_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Coupon < ActiveRecord::Base
end
