class AddDefaultTeamFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :team, :string, default: '1'
  end
end
