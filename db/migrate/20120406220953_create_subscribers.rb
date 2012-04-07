class CreateSubscribers < ActiveRecord::Migration
  def self.up
    create_table :subscribers do |t|
      t.string :email

      t.timestamps
    end
		add_index(:subscribers, :email, :unique=>true)
  end

  def self.down
    drop_table :subscribers
  end
end
