class CreateSreportTableService
  require 'rubyXL'
  require 'rubyXL/convenience_methods'

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
          row_sum = row_sum&.round
          total_team_sum += row_sum
          create_cell_bold_border(y, 2, row_sum)
          if style == 'time'
            create_cell_bold_border(y, x, row_sum)
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