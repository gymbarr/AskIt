class SubscriptionMailer < ApplicationMailer
  before_action do
    @user = params[:user]
    @category = params[:category]
    @question = params[:question]
  end

  def new_question_in_category
    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject', name: @category.name)} | AskIt"
    end
  end
end
