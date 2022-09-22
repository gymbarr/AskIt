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

    it 'renders the subject' do
      expect(subject.subject)
        .to eq("#{I18n.t('answer_mailer.notify_user_about_new_answer.subject')} | AskIt")
    end

    it 'renders the body' do
      expect(subject.body.encoded)
        .to match("#{I18n.t('answer_mailer.notify_user_about_new_answer.content', name: replier.username)}")
    end
  end
end
