class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.integer :time
      t.string :user_name
      t.references :timesheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
