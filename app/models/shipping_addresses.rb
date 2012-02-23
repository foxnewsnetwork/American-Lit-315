class ShippingAddresses < ActiveRecord::Base
end

# == Schema Information
#
# Table name: shipping_addresses
#
#  id         :integer(4)      not null, primary key
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :integer(4)
#  zip        :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

