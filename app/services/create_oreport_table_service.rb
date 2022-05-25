class CreateOreportTableService < ExcelOperation

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
end
