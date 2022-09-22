require "rails_helper"

RSpec.describe QuestionMailer, type: :mailer do
  describe '#notify_subscriber_about_new_question_in_category' do
    let(:question) { create :question, :with_categories }
    let(:categories) { question.categories }
    let(:categories_name) { categories.map(&:name).join(', ') }
    let(:user) { create :user }
    subject(:mail) do
      described_class.with(question: question,
                           user: user,
                           categories: categories,
                           categories_name: categories_name)
                     .notify_subscriber_about_new_question_in_category
                     .deliver_now
    end

    it 'sends email to the receiver emailname' do
      expect(subject.to[0]).to eq(user.email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'renders the subject' do
      expect(subject.subject)
        .to eq("#{I18n.t('question_mailer.notify_subscriber_about_new_question_in_category.subject', name: categories_name)} | AskIt")
    end

    it 'renders the body' do
      expect(subject.body.encoded)
        .to match("#{I18n.t('question_mailer.notify_subscriber_about_new_question_in_category.content_all_questions_in_category')}")
    end
  end
end
