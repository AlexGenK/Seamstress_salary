class AddTeamToProductions < ActiveRecord::Migration[6.1]
  def change
    add_column :productions, :team, :string
  end
end
