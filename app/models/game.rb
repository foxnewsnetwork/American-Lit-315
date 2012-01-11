# == Schema Information
#
# Table name: games
#
#  id           :integer(4)      not null, primary key
#  publisher_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

class Game < ActiveRecord::Base
	belongs_to :publisher
	
	has_many :game_stats
	has_many :users, :through => :game_stats
end
