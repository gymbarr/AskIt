require "rails_helper"

RSpec.describe QuestionMailer, type: :mailer do
  describe '#notify_subscriber_about_new_question_in_category' do
    subject(:question) { create :question }
    subject(:categories) { question.categories }
    subject(:categories_name) { categories.map(&:name).join(', ') }
    subject(:user) { create :user }
    subject(:mail) do
      described_class.with(question: question,
                           user: user,
                           categories: categories,
                           categories_name: categories_name)
                     .notify_subscriber_about_new_question_in_category
                     .deliver_now
    end

    it 'sends email to the receiver emailname' do
      expect(mail.to[0]).to eq(user.email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    context 'when locale set to en' do
      it 'renders the subject for en locale' do
        I18n.locale = :en
        expect(mail.subject).to match('New question')
      end

      it 'renders the body for en locale' do
        I18n.locale = :en
        expect(mail.body.encoded).to match('See all questions in the category:')
      end
    end

    context 'when locale set to ru' do
      it 'renders the subject for ru locale' do
        I18n.locale = :ru
        expect(mail.subject).to match('Новый вопрос')
      end

      # it 'renders the body for ru locale' do
      #   I18n.locale = :ru
      #   expect(mail.body.encoded).to match('Посмортеть все вопросы в категории:')
      # end
    end
  end
end
