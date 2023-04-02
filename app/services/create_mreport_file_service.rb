class CreateMreportFileService < ExcelOperation
  def self.call(models)
    @wb = RubyXL::Workbook.new
    @ws = @wb[0]
    @ws.sheet_name = 'ЗП'
    @ws.add_cell(0, 0, "ОТЧЕТ ПО МОДЕЛЯМ")
    @ws.add_cell(1, 0, "сгенерирован #{Time.now}")
    create_cell_bold_border(3, 0, 'Номер')
    create_cell_bold_border(3, 1, 'Наименование')
    create_cell_bold_border(3, 2, 'Тип')
    create_cell_bold_border(3, 3, 'Стоимость')
    y = 4
    @ws.change_column_width(0, 20)
    @ws.change_column_width(1, 60)
    @ws.change_column_width(2, 20)
    @ws.change_column_width(3, 20)
    models.each do |model|
      create_cell_border(y, 0, model.number)
      create_cell_border(y, 1, model.name)
      create_cell_border(y, 2, model.sewing)
      create_cell_border(y, 3, model.cost)
      y += 1
    end
    @wb.write('models_report.xlsx')
  end
end