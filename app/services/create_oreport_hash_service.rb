class CreateOreportHashService
  def self.call(scope)
    h = {}
    n = {}
    a = []
    scope.each do |production|
      @production = production
      @production.works.each do |work|
        h[work.model_number] = {} if h[work.model_number] == nil
        n[work.model_number] = {} if n[work.model_number] == nil
        work.executions.each do |execution|
          if h[work.model_number][execution.operation_number] == nil 
            h[work.model_number][execution.operation_number] = execution.quantity
            n[work.model_number][execution.operation_number] = @production.user_name
          else
            h[work.model_number][execution.operation_number] += execution.quantity
            n[work.model_number][execution.operation_number] += ", #{@production.user_name}"
          end
        end
      end
    end
    a << h
    a << n
    a
  end
end