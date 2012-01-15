# == Schema Information
#
# Table name: products
#
#  id             :integer(4)      not null, primary key
#  company_id     :integer(4)
#  ext_product_id :integer(4)
#  name           :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Product < ActiveRecord::Base
	belongs_to :company

	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }

end
