class AddAdminToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :bool, :default => false
    add_column :users, :banned, :bool, :default => false
  end
end
