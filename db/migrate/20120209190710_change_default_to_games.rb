class ChangeDefaultToGames < ActiveRecord::Migration
  def self.up
	change_column_default :games, :impressions, 0
	change_column_default :games, :earnings, 0 
  end

  def self.down
  end
end
