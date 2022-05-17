class CreateProductions < ActiveRecord::Migration[6.1]
  def change
    create_table :productions do |t|
      t.string :user_name
      t.date :date
      t.decimal :sum, precision: 10, scale: 3
      t.decimal :time, precision: 10, scale: 3

      t.timestamps
    end
  end
end
