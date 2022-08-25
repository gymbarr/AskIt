class SessionsController < ApplicationController
  before_action :already_logged_in?, only: %i[new create]

  def new; end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to questions_path, notice: t('.success')
    else
      flash.now[:alert] = t('.alert')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def already_logged_in?
    redirect_to root_path, alert: t('sessions.already_logged_in.alert') if logged_in?
  end
end
