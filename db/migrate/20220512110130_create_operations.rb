class CreateOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :operations do |t|
      t.string :number
      t.text :name
      t.string :kind
      t.integer :category
      t.decimal :time, precision: 5, scale: 3
      t.decimal :cost, precision: 7, scale: 3
      t.references :model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
