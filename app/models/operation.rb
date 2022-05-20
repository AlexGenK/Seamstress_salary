class Operation < ApplicationRecord
  validates :number, :name, :category, :time, presence: true

  def calc_cost!
    rank = Rank.find_by(sewing: self.model.sewing, category: self.category)
    begin
      self.cost = rank.cost * self.time
    rescue
      false 
    end
    true 
  end
end
