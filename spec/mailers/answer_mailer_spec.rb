require "rails_helper"

RSpec.describe AnswerMailer, type: :mailer do
  describe '#notify_user_about_new_answer' do
    let(:question) { create :question, :with_categories }
    let(:user) { question.user }
    let(:replier) { create :user }
    subject(:mail) do
      described_class.with(question: question,
                           user: user,
                           replier: replier)
                     .notify_user_about_new_answer
                     .deliver_now
    end

    it 'sends email to the receiver emailname' do
      expect(subject.to[0]).to eq(user.email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    context 'when locale set to en' do
      it 'renders the subject for en locale' do
        I18n.locale = :en
        expect(subject.subject).to eq("You've got a new reply to your question! | AskIt")
      end

      it 'renders the body for en locale' do
        I18n.locale = :en
        expect(subject.body.encoded).to match('left an answer to your question:')
      end
    end

    context 'when locale set to ru' do
      it 'renders the subject for ru locale' do
        I18n.locale = :ru
        expect(subject.subject).to eq('Вам оставили ответ на Ваш вопрос! | AskIt')
      end

      # it 'renders the body for ru locale' do
      #   I18n.locale = :ru
      #   expect(mail.body.encoded).to match('оставил ответ на Ваш вопрос:')
      # end
    end
  end
end
