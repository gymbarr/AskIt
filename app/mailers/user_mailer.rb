class UserMailer < ApplicationMailer
  def notify_subscriber
    @user = params[:user]
    @category = params[:category]
    @question = params[:question]

    mail to: @user.email, subject: "New question in the #{@category.name} category! | AskIt"
  end

  def notify_new_reply
    @question = params[:question]
    answer = params[:answer]
    @user = @question.user
    @replier = answer.user

    mail to: @user.email, subject: "You've got a new answer on your question! | AskIt"
  end
end
