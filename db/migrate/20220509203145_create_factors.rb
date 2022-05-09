class CreateFactors < ActiveRecord::Migration[6.1]
  def change
    create_table :factors do |t|
      t.integer :min
      t.integer :max
      t.integer :value

      t.timestamps
    end
  end
end
