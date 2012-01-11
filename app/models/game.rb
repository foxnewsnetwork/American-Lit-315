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
end
