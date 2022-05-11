class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :edit]

  def index
    @users = User.order(:email)
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin_role, :worker_role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
