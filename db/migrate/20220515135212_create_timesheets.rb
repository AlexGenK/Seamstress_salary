class CreateTimesheets < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheets do |t|
      t.date :date
      t.integer :sum

      t.timestamps
    end
  end
end
