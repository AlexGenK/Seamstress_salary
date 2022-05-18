class CreateExecutions < ActiveRecord::Migration[6.1]
  def change
    create_table :executions do |t|
      t.integer :quantity
      t.decimal :sum
      t.decimal :time
      t.references :work, null: false, foreign_key: true
      t.references :operation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
