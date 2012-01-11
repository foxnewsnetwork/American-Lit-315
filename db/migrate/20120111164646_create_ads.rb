class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.integer :company_id

      t.timestamps
    end
    
    add_index :ads, :company_id
  end

  def self.down
    drop_table :ads
  end
end
