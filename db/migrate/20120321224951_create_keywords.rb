class CreateKeywords < ActiveRecord::Migration
  def self.up
    create_table :keywords do |t|
      t.integer :product_id
      t.integer :type_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :keywords
  end
end
