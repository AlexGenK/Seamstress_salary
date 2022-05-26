class CreateAsortBonuses < ActiveRecord::Migration[6.1]
  def change
    create_table :asort_bonuses do |t|
      t.decimal :factor, default: 0, precision: 6, scale: 4

      t.timestamps
    end
  end
end
