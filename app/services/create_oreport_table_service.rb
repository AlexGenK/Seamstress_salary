class CreateOreportTableService
  require 'rubyXL'
  require 'rubyXL/convenience_methods'

  def self.call(model_hash, models_list, date)
    bonus = Bonus.get_by_my(date)
    @wb = RubyXL::Workbook.new
    @ws = @wb[0]
    @ws.sheet_name = 'ЗП'
    @ws.add_cell(0, 0, "ОТЧЕТ ПО ПРОИЗВОДСТВЕННЫМ ОПЕРАЦИЯМ ЗА #{I18n.l(date, format: '%B %Y')}")
    @ws.add_cell(1, 0, "сгенерирован #{Time.now}")
    create_table(model_hash, models_list)
    @wb
  end

  private

  def self.create_table(model_hash, models_list)
    
  end

  def self.create_cell_bold(y, x, content)
    @ws.add_cell(y, x, content)
    @ws.sheet_data[y][x].change_font_bold(:true)
  end

  def self.create_cell_bold_right(y, x, content)
    create_cell_bold(y, x, content)
    @ws.sheet_data[y][x].change_horizontal_alignment('right')
  end  

  def self.create_cell_border(y, x, content)
    @ws.add_cell(y, x, content)
    @ws.sheet_data[y][x].change_border(:left, 'thin')
    @ws.sheet_data[y][x].change_border(:right, 'thin')
    @ws.sheet_data[y][x].change_border(:top, 'thin')
    @ws.sheet_data[y][x].change_border(:bottom, 'thin')
  end

  def self.create_cell_border_right(y, x, content)
    create_cell_border(y, x, content)
    @ws.sheet_data[y][x].change_horizontal_alignment('right')
  end

  def self.create_cell_border_center(y, x, content)
    create_cell_border(y, x, content)
    @ws.sheet_data[y][x].change_horizontal_alignment('center')
  end

  def self.create_cell_bold_border(y, x, content)
    create_cell_border(y, x, content)
    @ws.sheet_data[y][x].change_font_bold(:true)
  end

  def self.create_cell_bold_border_right(y, x, content)
    create_cell_bold_border(y, x, content)
    @ws.sheet_data[y][x].change_horizontal_alignment('right')
  end

  def self.change_all_borders(cell, style)
    cell.change_border(:left, style)
    cell.change_border(:right, style)
    cell.change_border(:top, style)
    cell.change_border(:bottom, style)
  end
end