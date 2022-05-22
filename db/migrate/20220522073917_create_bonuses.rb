class CreateBonuses < ActiveRecord::Migration[6.1]
  def change
    create_table :bonuses do |t|
      t.date :date
      t.integer :sum_prod
      t.integer :sum_ts

      t.timestamps
    end
  end
end
