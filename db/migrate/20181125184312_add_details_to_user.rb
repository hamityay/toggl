class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :is_active, :boolean, default: true
    add_column :users, :is_admin, :boolean, default: false
  end
end
