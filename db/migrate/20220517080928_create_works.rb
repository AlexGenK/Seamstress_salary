class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.decimal :sum, precision: 10, scale: 3
      t.decimal :time, precision: 10, scale: 3
      t.references :production, null: false, foreign_key: true
      t.references :model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
