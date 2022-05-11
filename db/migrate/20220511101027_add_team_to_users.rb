class AddTeamToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :team, :string
  end
end
