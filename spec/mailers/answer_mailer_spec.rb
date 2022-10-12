require 'rails_helper'

RSpec.describe AnswerMailer, type: :mailer do
  describe '#notify_user_about_new_answer' do
    subject(:mail) do
      described_class.with(question: question,
                           user: user,
                           replier: replier)
                     .notify_user_about_new_answer
                     .deliver_now
    end

    let(:question) { create :question, :with_categories }
    let(:user) { question.user }
    let(:replier) { create :user }

    it 'sends email to the receiver emailname' do
      expect(subject.to[0]).to eq(user.email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    context 'when locale is en' do
      before do
        I18n.locale = :en
      end

      it 'renders the subject' do
        expect(subject.subject)
          .to eq("You've got a new reply to your question! | AskIt")
      end

      it 'renders the body' do
        expect(subject.text_part.body.encoded)
          .to match(/left an answer to your question:/)
        expect(subject.html_part.body.encoded)
          .to match(/left an answer to your question:/)
      end
    end

    context 'when locale is ru' do
      before do
        I18n.locale = :ru
      end

      let(:user) { create :user, locale: 'ru' }

      it 'renders the subject' do
        expect(subject.subject)
          .to eq('Вам оставили ответ на Ваш вопрос! | AskIt')
      end

      it 'renders the body' do
        expect(subject.text_part.body.encoded)
          .to match(/оставил ответ на Ваш вопрос:/)
        expect(subject.html_part.body.encoded)
          .to match(/оставил ответ на Ваш вопрос:/)
      end
    end
  end
end
