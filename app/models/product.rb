class Product < ActiveRecord::Base
	belongs_to :company

	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	
	attr_accessible :company_id, :name, :description, :meta_data

end

# == Schema Information
#
# Table name: products
#
#  id                   :integer(4)      not null, primary key
#  company_id           :integer(4)
#  ext_product_id       :integer(4)
#  name                 :string(255)
#  description          :text
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  picture_updated_at   :datetime
#  meta_data            :text
#  price                :decimal(8, 2)   default(0.0)
#  clicked_through      :integer(4)      default(0)
#  purchased            :integer(4)      default(0)
#

