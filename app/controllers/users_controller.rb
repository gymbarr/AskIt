class UsersController < ApplicationController
  before_action :user, only: %i[edit]
  before_action :authorize_user!
  after_action :verify_authorized

  def edit; end

  def update
    if user.update(user_params)
      redirect_to users_path, notice: t('.success')
    else
      redirect_to edit_user_path(user), alert: t('.alert')
    end
  end

  def index
    @users = User.order(created_at: :desc)
  end

  def destroy
    if user.destroy
      redirect_to users_path, notice: t('.success')
    else
      flash[:alert] = t('.alert')
      redirect_back fallback_location: root_path
    end
  end

  private

  def user_params
    params.require(:user).permit({ role_ids: [] })
  end

  def user
    @user ||= User.find(params[:id])
  end

  def authorize_user!
    authorize(@user || User)
  end
end
