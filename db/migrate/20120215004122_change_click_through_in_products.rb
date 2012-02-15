class ChangeClickThroughInProducts < ActiveRecord::Migration
  def self.up
	add_column :products, :click_through, :integer, :default=>0
	remove_column :products, :clicked_through
  end

  def self.down
	add_column :products, :clicked_through, :integer, :default=>0
	remove_column :products, :click_through
  end
end
