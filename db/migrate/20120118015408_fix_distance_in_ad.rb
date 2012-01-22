class FixDistanceInAd < ActiveRecord::Migration
  def self.up
  	alter_column :ads, :distance, :integer, :default => 0
  	add_index :ads, :distance
  end

  def self.down
  	remove_index :ads, :distance
  	alter_column :ads, :distance, :decimal, :default => 0.0
  end
end
