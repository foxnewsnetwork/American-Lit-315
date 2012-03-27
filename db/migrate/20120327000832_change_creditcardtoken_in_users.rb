class ChangeCreditcardtokenInUsers < ActiveRecord::Migration
  def self.up
		add_column :users, :stripe_id, :string
		remove_column :users, :credit_card_token
  end

  def self.down
		add_column :users, :credit_card_token, :string
		remove_column :users, :stripe_id
  end
end
