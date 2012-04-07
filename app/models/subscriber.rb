class Subscriber < ActiveRecord::Base
  attr_accessible :email

	validates_presence_of :email, :message=>'needs your email'
	validates_uniqueness_of :email

	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end
