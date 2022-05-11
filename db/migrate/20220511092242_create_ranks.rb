class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.string :type
      t.integer :category
      t.integer :cost

      t.timestamps
    end
  end
end
