class Subscriber < ActiveRecord::Base
  attr_accessible :email

	validates_presence_of :email, :message=>'needs your email'
	validates_uniqueness_of :email

	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end

# == Schema Information
#
# Table name: subscribers
#
#  id         :integer(4)      not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

