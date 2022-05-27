class AsortBonusController < ApplicationController
  def edit
    @ab = AsortBonus.first
    if @ab == nil
      @ab = AsortBonus.new
      @ab.save
    end
  end

  def update
    @ab = AsortBonus.first
    flash[:alert] = 'Невозможно отредактировать коэффициент' unless @ab.update(asort_bonus_params)
    redirect_to edit_asort_bonus_path
  end

  private

  def asort_bonus_params
    params.require(:asort_bonus).permit(:factor)
  end
end
