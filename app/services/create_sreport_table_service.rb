class CreateSreportTableService
  require 'rubyXL'
  require 'rubyXL/convenience_methods'

  def self.call(table_hash, models_list)
    wb = RubyXL::Workbook.new
    ws = wb[0]
    ws.add_cell(0, 1, 'бригада')
    change_all_borders(ws.sheet_data[0][1], 'thin')
    ws.add_cell(0, 2, 'Итого:')
    change_all_borders(ws.sheet_data[0][2], 'thin')
    ws.sheet_data[0][2].change_font_bold(:true)
    x = 3
    y = 0
    models_list.each do |model|
      ws.add_cell(y, x, model)
      ws.sheet_data[y][x].change_horizontal_alignment('center')
      change_all_borders(ws.sheet_data[y][x], 'thin')
      x += 1
    end
    
    table_hash.each do |team, users|
      users.each do |user|
        user.each do |name, works|
          y += 1
          ws.add_cell(y, 0, name)
          change_all_borders(ws.sheet_data[y][0], 'thin')
          ws.add_cell(y, 1, team)
          ws.sheet_data[y][1].change_horizontal_alignment('right')
          change_all_borders(ws.sheet_data[y][1], 'thin')
          x = 3
          row_sum = 0
          works.each do |name, sum|
            ws.add_cell(y, x, sum == 0 ? '' : sum)
            change_all_borders(ws.sheet_data[y][x], 'thin')
            x +=1
            row_sum += sum
          end
          ws.add_cell(y, 2, row_sum)
          change_all_borders(ws.sheet_data[y][2], 'thin')
          ws.sheet_data[y][2].change_font_bold(:true)
        end
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