class AddVisibilityToModels < ActiveRecord::Migration[6.1]
  def change
    add_column :models, :visibility, :boolean, default: true
  end
end
