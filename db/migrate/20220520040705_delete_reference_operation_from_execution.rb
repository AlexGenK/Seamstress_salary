class DeleteReferenceOperationFromExecution < ActiveRecord::Migration[6.1]
  def change
    remove_reference :executions, :operation, index:true, foreign_key: true
    add_column :executions, :operation_id, :bigint
    add_column :executions, :operation_number, :string
    add_column :executions, :operation_name, :string
    add_column :executions, :operation_time, :decimal, precision: 5, scale: 3
    add_column :executions, :operation_cost, :decimal, precision: 7, scale: 3
  end
end
