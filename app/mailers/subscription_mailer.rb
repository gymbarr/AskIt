class SubscriptionMailer < ApplicationMailer
  def new_question_in_category
    @question = Question.find(params[:question_id])
    @user = User.find(params[:user_id])

    @categories = @question.categories.where(id: @user.subscription_categories)
    @categories_name = @categories.map(&:name).join(', ')

    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject', name: @categories_name)} | AskIt"
    end
  end
end
