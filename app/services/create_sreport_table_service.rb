class CreateSreportTableService
  require 'rubyXL'
  require 'rubyXL/convenience_methods'

  def self.call(table_hash, models_list)
    wb = RubyXL::Workbook.new
    ws = wb[0]
    x = 1
    y = 0
    models_list.each do |model|
      ws.add_cell(y, x, model)
      ws.sheet_data[y][x].change_horizontal_alignment('center')
      change_all_borders(ws.sheet_data[y][x], 'thin')
      x += 1
    end
    
    table_hash.each do |name, works|
      y += 1
      ws.add_cell(y, 0, name)
      change_all_borders(ws.sheet_data[y][0], 'thin')
        x = 1
        works.each do |name, sum|
          ws.add_cell(y, x, sum == 0 ? '' : sum)
          change_all_borders(ws.sheet_data[y][x], 'thin')
          x +=1
        end
    end
    wb
  end

  private

  def self.change_all_borders(cell, style)
    cell.change_border(:left, style)
    cell.change_border(:right, style)
    cell.change_border(:top, style)
    cell.change_border(:bottom, style)
  end
end