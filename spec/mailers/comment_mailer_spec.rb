require "rails_helper"

RSpec.describe CommentMailer, type: :mailer do
  describe '#notify_user_about_new_comment' do
    subject(:question) { create :question }
    subject(:user) { create :user }
    subject(:replier) { create :user }
    subject(:mail) do
      described_class.with(question: question,
                           user: user,
                           replier: replier)
                     .notify_user_about_new_comment
                     .deliver_now
    end

    it 'sends email to the receiver emailname' do
      expect(mail.to[0]).to eq(user.email)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    context 'when locale set to en' do
      it 'renders the subject for en locale' do
        I18n.locale = :en
        expect(mail.subject).to eq("You've got a new comment! | AskIt")
      end

      it 'renders the body for en locale' do
        I18n.locale = :en
        expect(mail.body.encoded).to match('left a comment to you:')
      end
    end

    context 'when locale set to ru' do
      it 'renders the subject for ru locale' do
        I18n.locale = :ru
        expect(mail.subject).to eq('Вам оставили комментарий! | AskIt')
      end

      # it 'renders the body for ru locale' do
      #   I18n.locale = :ru
      #   expect(mail.body.encoded).to match('оставил Вам комментарий:')
      # end
    end
  end
end
