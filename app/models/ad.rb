# == Schema Information
#
# Table name: ads
#
#  id                  :integer(4)      not null, primary key
#  company_id          :integer(4)
#  limit               :integer(4)
#  type                :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#  name                :string(255)
#  description         :text
#  cost_per_impression :integer(10)
#  cost_per_click      :integer(10)
#  cost_per_purchase   :integer(10)
#  love_hate           :integer(4)
#  relief_fear         :integer(4)
#  excite_bore         :integer(4)
#  happy_sad           :integer(4)
#  funny_serious       :integer(4)
#  sexy_disgust        :integer(4)
#

class Ad < ActiveRecord::Base
	belongs_to :company
	
	has_many :ad_stats
	has_many :users, :through => :ad_stats

	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100"}
end
