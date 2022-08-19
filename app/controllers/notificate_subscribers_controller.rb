class NotificateSubscribersController < ApplicationController
  def create
    NotificateSubscribersMailer.with(users: @users, category: @category).notificate_email.deliver_later
  end
end