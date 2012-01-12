# == Schema Information
#
# Table name: ads
#
#  id         :integer(4)      not null, primary key
#  company_id :integer(4)
#  limit      :integer(4)
#  type       :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Ad < ActiveRecord::Base
	belongs_to :company
end
