class ChangeStuffToGames < ActiveRecord::Migration
  def self.up
    remove_column :games, :earnings
	add_column :games, :earnings, :decimal, :precision=>10, :scale=>2, :default=>0
  end

  def self.down
    remove_column :games, :earnings
	add_column :games, :earnings, :decimal,:precision=>10, :default=>0
  end
end
