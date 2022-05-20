class RenameModelNameColumnFromWorks < ActiveRecord::Migration[6.1]
  def change
    rename_column :works, :model_name, :model_nname
  end
end
