require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  pending "add some examples to (or delete) #{__FILE__}"
end
require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#notify_subscriber', :fast do
    context 'instant mail sending' do
      let(:category) { create :category }
      let(:question) { create :question }
      let(:user) { question.user }
      let(:mail) do
        described_class.with(user: user, category: category, question: question).notify_subscriber.deliver_now
      end

      it 'renders the receiver emailname' do
        expect(mail.to[0]).to eq(user.email)
      end

      it 'renders the subject' do
        expect(mail.subject).to eq("New question in the #{category.name} category! | AskIt")
      end

      it 'should send an email' do
        mail
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end

    it 'enqueues email sending to a background job' do
      expect do
        described_class.notify_subscriber.deliver_later
      end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
    end
  end
end
