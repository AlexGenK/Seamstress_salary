class ChangeFactorValueFromIntegerToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column :factors, :value, :decimal, precision: 4, scale: 2
  end
end
