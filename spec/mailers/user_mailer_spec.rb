require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  pending "add some examples to (or delete) #{__FILE__}"
end
require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  subject(:category) { create :category }
  subject(:question) { create :question }
  subject(:user) { question.user }
  subject(:mail) do
    described_class.with(user: user, category: category, question: question).notify_subscriber.deliver_now
  end

  describe '#notify_subscriber', :fast do
    context 'when instant mail sending' do
      it 'renders the receiver emailname' do
        expect(mail.to[0]).to eq(user.email)
      end

      context 'when locale set to en' do
        it 'renders the subject for en locale' do
          I18n.locale = :en
          expect(mail.subject).to eq("New question in the #{category.name} category! | AskIt")
        end
      end

      context 'when locale set to ru' do
        it 'renders the subject for ru locale' do
          I18n.locale = :ru
          expect(mail.subject).to eq("Новый вопрос в категории #{category.name}! | AskIt")
        end
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
