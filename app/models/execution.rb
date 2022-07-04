class Execution < ApplicationRecord
  validates :quantity, :sum, :time, presence: true

  belongs_to :work

  def calculate_sum
    @oper = Operation.find(self.operation_id)
    if @oper != nil 
      self.operation_cost = @oper.cost
      self.sum = self.operation_cost * self.quantity
    end
  end
end
