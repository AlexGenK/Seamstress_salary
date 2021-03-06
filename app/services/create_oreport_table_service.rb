class CreateOreportTableService < ExcelOperation

  def self.call(model_hash, models_list, date)
    bonus = Bonus.get_by_my(date)
    @wb = RubyXL::Workbook.new
    create_table(model_hash, models_list, date)
    @wb
  end

  private

  def self.create_table(model_hash, models_list, date)
    models_list.each do |model_number|
      @ws = @wb.add_worksheet(model_number.gsub(/\//,'-'))
      @ws.sheet_name = model_number.gsub(/\//,'-')
      @ws.change_column_width(1, 60)
      @ws.change_column_width(2, 20)
      @ws.change_column_width(3, 20)
      @ws.change_column_width(4, 20)
      @ws.change_column_width(5, 40)
      model = Model.find_by(number: model_number)
      if model == nil
        @ws.add_cell(0, 0, "МОДЕЛЬ С НОМЕРОМ '#{model_number}' НЕ НАЙДЕНА В СПРАВОЧНИКАХ")
      else
        @ws.add_cell(0, 0, "ОТЧЕТ ПО ПРОИЗВОДСТВЕННЫМ ОПЕРАЦИЯМ ЗА #{I18n.l(date, format: '%B %Y')}")
        @ws.add_cell(1, 0, "сгенерирован #{Time.now}")
        @ws.add_cell(3, 0, "#{model_number} - #{model.name}")
        oper_hash = model_hash[0][model_number]
        name_hash = model_hash[1][model_number]
        operations = model.operations.order(Arel.sql("(substring(number, '^[0-9]+'))::int, substring(concat(number, '!'), '[^0-9_].*$')"))
        base_quant = oper_hash['1'] == nil ? 0 : oper_hash['1']

        create_cell_bold_border(5, 0, "N")
        create_cell_bold_border(5, 1, "Наименование")
        create_cell_bold_border(5, 2, "По первой операции")
        create_cell_bold_border(5, 3, "По отчетам")
        create_cell_bold_border(5, 4, "Отклонение")
        create_cell_bold_border(5, 5, "Исполнители")
        y = 6
        operations.each do |oper|
          oper_quant = oper_hash[oper.number] == nil ? 0 : oper_hash[oper.number]
          oper_names = name_hash[oper.number] == nil ? '' : name_hash[oper.number]
          create_cell_border(y, 0, oper.number)
          create_cell_border(y, 1, oper.name)
          create_cell_border(y, 2, base_quant)
          create_cell_border(y, 3, oper_quant)
          divergence = base_quant - oper_quant
          create_cell_border(y, 4, divergence)
          if divergence > 0
            @ws[y][4].change_fill('90ee90') 
          elsif divergence < 0
            @ws[y][4].change_fill('ff0000') 
          end
          create_cell_border(y, 5, oper_names)
          y += 1
        end
      end
    end
    @wb.worksheets.delete_at(0)
  end
end
