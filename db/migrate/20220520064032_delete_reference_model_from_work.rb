class DeleteReferenceModelFromWork < ActiveRecord::Migration[6.1]
  def change
    remove_reference :works, :model, index:true, foreign_key: true
    add_column :works, :model_id, :bigint
    add_column :works, :model_name, :text
    add_column :works, :model_number, :string
  end
end
