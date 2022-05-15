class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :edit]

  def index
    @users = User.order(:name)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      flash[:alert] = 'Невозможно отредактировать пользователя'
      render :edit
    end
  end

  def destroy
    if @user.is_last_admin?
      flash[:alert] = 'Невозможно удалить последнего администратора'
    else
      @user.destroy ? flash[:notice] = 'Пользователь был удален' : flash[:alert] = 'Невозможно удалить пользователя'
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin_role, :worker_role, :team)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
