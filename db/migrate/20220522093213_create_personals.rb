class CreatePersonals < ActiveRecord::Migration[6.1]
  def change
    create_table :personals do |t|
      t.string :user_name
      t.integer :report_time
      t.integer :timesheet_time
      t.integer :execution
      t.decimal :factor, precision: 4, scale: 2
      t.references :bonus, null: false, foreign_key: true

      t.timestamps
    end
  end
end
