class AddStripeidToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :stripe_id, :string
  end

  def self.down
    remove_column :invoices, :stripe_id
  end
end
