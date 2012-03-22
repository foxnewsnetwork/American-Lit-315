# == Schema Information
#
# Table name: keywords
#
#  id         :integer(4)      not null, primary key
#  product_id :integer(4)
#  type_id    :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Keyword < ActiveRecord::Base
	belongs_to :product

	belongs_to :type
	attr_accessible :product_id,:name,:type_id
end

