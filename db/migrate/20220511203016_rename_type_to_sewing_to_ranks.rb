class RenameTypeToSewingToRanks < ActiveRecord::Migration[6.1]
  def change
    rename_column :ranks, :type, :sewing
  end
end
