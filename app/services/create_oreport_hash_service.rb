class CreateOreportHashService
  def self.call(scope)
    h = {}
    scope.each do |production|
      production.works.each do |work|
        h[work.model_number] = {} if h[work.model_number] == nil
        work.executions.each do |execution|
          if h[work.model_number][execution.operation_number] == nil 
            h[work.model_number][execution.operation_number] = execution.quantity
          else
            h[work.model_number][execution.operation_number] += execution.quantity
          end
        end
      end
    end
    h
  end
end