# == Schema Information
#
# Table name: coupons
#
#  id                   :integer(4)      not null, primary key
#  company_id           :integer(4)
#  created_at           :datetime
#  updated_at           :datetime
#  name                 :string(255)
#  description          :text
#  cost_per_redeem      :integer(10)
#  limit                :integer(4)
#  redeemed             :integer(4)
#  ext_coupon_id        :integer(4)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  picture_updated_at   :datetime
#  meta_data            :text
#

require 'spec_helper'

describe Coupon do
  pending "add some examples to (or delete) #{__FILE__}"
end
