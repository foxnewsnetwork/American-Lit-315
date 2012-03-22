class Product < ActiveRecord::Base
	belongs_to :company

	has_many :keyword

	has_attached_file :picture, :styles => { :medium => "300x300>", :small => "100x100>", :thumb => "75x75" }
	
	attr_accessible :company_id, :name, :description, :meta_data, :picture,:price,:product_type

  def to_jq_upload
    {
      "name" => picture_file_name,
      "size" => picture_file_size,
      "url" => picture.url,
      "thumbnail_url" => picture.thumb.url,
      "delete_url" => picture_path(:id => id),
      "delete_type" => "DELETE" 
    }
  end

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
#  purchased            :integer(4)      default(0)
#  displayed            :integer(4)      default(0)
#  click_through        :integer(4)      default(0)
#  product_type         :string(255)
#

