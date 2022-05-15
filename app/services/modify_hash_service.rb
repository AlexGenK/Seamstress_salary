class ModifyHashService

  def self.to_operations(a)
    consumptions_array = self.to_i(a, :category)
    consumptions_array = self.to_f(a, :time)
  end

  def self.to_i(a, key)
    a.each do |item|
      item[key] = item[key].to_i
    end
  end

  def self.to_f(a, key)
    a.each do |item|
      item[key] = item[key].gsub!(',', '.').to_f
    end
  end

  def self.to_date(a, key)
    a.each do |item|
      item[key] = Date.strptime(item[key], '%d.%m.%y')
    end
  end

end
