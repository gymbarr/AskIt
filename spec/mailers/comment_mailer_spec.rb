require 'rails_helper'

RSpec.describe CommentMailer, type: :mailer do
  describe '#notify_user_about_new_comment' do
    subject(:mail) do
      described_class.with(question: question,
                           user: user,
                           replier: replier)
                     .notify_user_about_new_comment
                     .deliver_now
    end

    let(:question) { create :question, :with_categories }
    let(:user) { create :user }
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
          .to eq("You've got a new comment! | AskIt")
      end

      it 'renders the body' do
        expect(subject.text_part.body.encoded)
          .to match(/left a comment to you:/)
        expect(subject.html_part.body.encoded)
          .to match(/left a comment to you:/)
      end
    end

    context 'when locale is ru' do
      before do
        I18n.locale = :ru
      end

      let(:user) { create :user, locale: 'ru' }

      it 'renders the subject' do
        expect(subject.subject)
          .to eq('Вам оставили комментарий! | AskIt')
      end

      it 'renders the body' do
        expect(subject.text_part.body.encoded)
          .to match(/оставил Вам комментарий:/)
        expect(subject.html_part.body.encoded)
          .to match(/оставил Вам комментарий:/)
      end
    end
  end
end
