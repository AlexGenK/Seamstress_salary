class CreateSurcharges < ActiveRecord::Migration[6.1]
  def change
    create_table :surcharges do |t|
      t.date :date
      t.string :user_name
      t.string :comment
      t.integer :sum

      t.timestamps
    end
  end
end
