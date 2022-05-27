class CreateSreportTableService < ExcelOperation

  def self.call(sum_hash, time_hash, models_list, date)
    bonus = Bonus.get_by_my(date)
    @wb = RubyXL::Workbook.new
    @ws = @wb[0]
    @ws.sheet_name = 'ЗП'
    @ws.add_cell(0, 0, "ОТЧЕТ ПО ЗАРПЛАТЕ ЗА #{I18n.l(date, format: '%B %Y')}")
    @ws.add_cell(1, 0, "сгенерирован #{Time.now}")
    create_table(sum_hash, models_list, bonus, 'salary')
    @ws = @wb.add_worksheet('Время')
    @ws.add_cell(0, 0, "ОТЧЕТ ПО ЗАТРАЧЕНОМУ ВРЕМЕНИ ЗА #{I18n.l(date, format: '%B %Y')}")
    @ws.add_cell(1, 0, "сгенерирован #{Time.now}")
    create_table(time_hash, models_list, bonus, 'time')
  end

  private

  def self.create_table(table_hash, models_list, bonus, style)
    # ФОРМИРУЕМ ШАПКУ ТАБЛИЦЫ
    y = 3
    create_cell_border(y, 0, '')
    create_cell_border(y, 1, 'бригада')
    create_cell_bold_border(y, 2, 'Итого:')
    x = 3
    models_list.each do |model|
      create_cell_border_center(y, x, model)
      x += 1
    end
    if style == 'time'
      create_cell_bold_border(y, x, 'Итого:')
      x += 1
      create_cell_border(y, x, 'Табель')
      x += 1
      create_cell_border(y, x, 'План %')
      x += 1
      create_cell_border(y, x, 'Премия %')
    else
      create_cell_bold_border(y, x, 'Итого:')
      x += 1
      create_cell_bold_border_wrap(y, x, '% за план')
      x += 1
      create_cell_bold_border_wrap(y, x, 'Премия за план')
      x += 1
      create_cell_bold_border_wrap(y, x, '% за асортимент')
      x += 1
      create_cell_bold_border_wrap(y, x, 'Премия за асортимент')  
    end

    # УСТАНАВЛИВАЕМ ШИРИНУ СТОЛБЦОВ
    (0..x).each do |i|
      @ws.change_column_width(i, 12)
    end
    
    col_sum = {}
    total_sum = 0
    table_hash.each do |team, users|
      team_col_sum = {}
      total_team_sum = 0
      users.each do |user|
        user.each do |name, works|
          y += 1
          create_cell_border(y, 0, name)
          create_cell_border_right(y, 1, team)
          x = 3
          row_sum = 0
          works.each do |name, sum|
            create_cell_border(y, x, sum == 0 ? '' : sum)
            x +=1
            row_sum += sum
            if team_col_sum[name] == nil
              team_col_sum[name] = sum
            else 
              team_col_sum[name] += sum
            end
            if col_sum[name] == nil
              col_sum[name] = sum
            else 
              col_sum[name] += sum
            end
          end

          # РАСЧЕТ СУММАРНЫХ КОЛОНОК СЛЕВА И СПРАВА          
          row_sum = row_sum&.round
          total_team_sum += row_sum
          create_cell_bold_border(y, 2, row_sum)
          create_cell_bold_border(y, x, row_sum)

          # РАСЧЕТ ПРАВЫХ СУММАРНЫХ КОЛОНОК С БОНУСАМИ
          # для таблицы времени
          if style == 'time'
            x += 1
            if bonus != nil
              personal = bonus.personals.find_by(user_name: name)
              if personal !=nil
                create_cell_border(y, x, personal.timesheet_time)
                x += 1
                create_cell_border(y, x, personal.execution)
                x += 1
                create_cell_border(y, x, personal.factor)
                x += 1
              else
                create_cell_border(y, x, '')
                x += 1
                create_cell_border(y, x, '')
                x += 1
                create_cell_border(y, x, '')
                x += 1
              end
            else
              create_cell_border(y, x, '')
              x += 1
              create_cell_border(y, x, '')
              x += 1
              create_cell_border(y, x, '')
              x += 1
            end
          # для таблицы зарплаты
          else
            # бонусы за выполнение плана
            x += 1
            if bonus != nil
              personal = bonus.personals.find_by(user_name: name)
              if personal !=nil
                create_cell_border(y, x, personal.factor)
                x += 1
                create_cell_bold_border(y, x, (personal.factor * row_sum).round)
              else
                create_cell_border(y, x, '')
                x += 1
                create_cell_border(y, x, '')
              end
            else
              create_cell_border(y, x, '')
              x += 1
              create_cell_border(y, x, '')
            end
            # бонусы за асортимент
            factor_oper = (works.count{|key,value| value > 0}) * AsortBonus.first.factor
            x += 1
            create_cell_border(y, x, factor_oper)
            x += 1
            create_cell_bold_border(y, x, (factor_oper * row_sum).round)
          end
        end
      end
      total_sum += total_team_sum
      y += 1
      x = 3
      create_cell_border(y, 0, '')
      create_cell_bold_border_right(y, 1, 'Всего:')
      create_cell_bold_border(y, 2, total_team_sum)
      team_col_sum.each do |name, sum|
        create_cell_bold_border(y, x, sum)
        x += 1
      end
      if style == 'time'
        create_cell_border(y, x, '')
        x += 1
        create_cell_border(y, x, '')
        x += 1
        create_cell_border(y, x, '')
        x += 1
        create_cell_border(y, x, '')
        x += 1
      end   
    end
    y += 1
    x = 3
    create_cell_bold_right(y, 1, 'Итого:')
    create_cell_bold(y, 2, total_sum)
    col_sum.each do |name, sum|
      create_cell_bold(y, x, sum)
      x += 1
    end
    @wb
  end
end