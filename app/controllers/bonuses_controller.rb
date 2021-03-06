class BonusesController < ApplicationController
  before_action :set_bonus, only: [:destroy]
  load_and_authorize_resource

  def index
    @bonus = Bonus.new(date: Date.today)
    @pagy, @bonuses = pagy(Bonus.order(date: :desc))
    session[:page] = @pagy.page
  end

  def create
    @bonus = Bonus.new(bonus_params)
    if Bonus.get_by_my(@bonus.date) != nil
      flash[:alert] = 'Расчет премиальных коэффициентов за этот месяц уже существует'
    else
      if @bonus.save
        current_productions = GetProductionsQuery.call(@bonus.date, 'Все')
        workers_list = GetProductionsListsQuery.workers(current_productions)
        timesheet = Timesheet.where('extract (year from date) = ? AND extract (month from date) = ?', @bonus.date.year, @bonus.date.month)[0]
        workers_list.each do |worker|
          report_time = current_productions.find_by(user_name: worker).time.round
          begin
            timesheet_time = timesheet.visits.find_by(user_name: worker).time
          rescue
            flash[:alert] = "Расчет премиальных коэффициентов не выполнен. Работник #{worker} отсутствует в табеле."
            redirect_to bonuses_path
            return
          end
          execution = (100*report_time/timesheet_time).round
          factor = Factor.get_by_percent(execution)
          @personal = @bonus.personals.new(user_name: worker,
                                          report_time: report_time, 
                                          timesheet_time: timesheet_time,
                                          execution: execution,
                                          factor: factor)
          @personal.save
        end
        @bonus.calculate_sum
      else
        flash[:alert] = 'Невозможно добавить расчет премиальных коэффициентов'
      end
    end
    redirect_to bonuses_path
  end

  def destroy
    flash[:alert] = 'Невозможно удалить расчет' unless @bonus.destroy
    redirect_to bonuses_path(page: session[:page])
  end

  private

  def set_bonus
    @bonus = Bonus.find(params[:id])
  end

  def bonus_params
    params.require(:bonus).permit(:date, :sum_prod, :sum_ts)
  end
end
