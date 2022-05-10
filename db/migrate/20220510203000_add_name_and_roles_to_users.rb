class AddNameAndRolesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :admin_role, :boolean, default: false
    add_column :users, :worker_role, :boolean, default: true
  end
end
