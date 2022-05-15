class MassCreateOperationsQuery

  def self.call(model, h)

    @counter = []
    model.operations.all.destroy_all
    h.each do |item|
      operation = model.operations.new(item)
      operation.calc_cost!
      operation.save
    end
    return @counter
  end
end