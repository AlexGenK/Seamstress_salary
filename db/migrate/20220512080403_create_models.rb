class CreateModels < ActiveRecord::Migration[6.1]
  def change
    create_table :models do |t|
      t.string :sewing
      t.text :name
      t.string :number
      t.integer :cost, default: 0

      t.timestamps
    end
  end
end
