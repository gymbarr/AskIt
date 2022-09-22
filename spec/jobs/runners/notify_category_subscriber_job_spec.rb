require 'rails_helper'

RSpec.describe Runners::NotifyCategorySubscriberJob, type: :job do
  include ActiveJob::TestHelper
  let(:question) { create :question, :with_categories }
  let(:subscriber) { create :user, subscription_categories: question.categories }

  describe '#perform_later' do
    subject(:job) { described_class.perform_later(question.id, subscriber.id) }

    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(question.id, subscriber.id).on_queue('notifiers')
    end
  end

  describe '#perform_now' do
    context 'when valid parameters were passed' do
      subject(:job) { described_class.perform_now(question.id, subscriber.id) }

      it 'calls on QuestionMailer' do
        allow(QuestionMailer).to receive_message_chain(:with,
                                                       :notify_subscriber_about_new_question_in_category,
                                                       :deliver_now)
        subject
        expect(QuestionMailer).to have_received(:with).with(hash_including(question: question,
                                                                           user: subscriber))
      end
    end

    context 'when invalid parameters were passed' do
      it 'does not call on QuestionMailer with non existing subscriber' do
        allow(QuestionMailer).to receive_message_chain(:with,
                                                       :notify_subscriber_about_new_question_in_category,
                                                       :deliver_now)
        described_class.perform_now(question.id, 999)
        expect(QuestionMailer).not_to have_received(:with)
      end

      it 'does not call on QuestionMailer with non existing question' do
        allow(QuestionMailer).to receive_message_chain(:with,
                                                       :notify_subscriber_about_new_question_in_category,
                                                       :deliver_now)
        described_class.perform_now(999, subscriber.id)
        expect(QuestionMailer).not_to have_received(:with)
      end
    end
  end
end
