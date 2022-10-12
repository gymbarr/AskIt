# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Runners::NotifyCategorySubscriberJob, type: :job do
  include ActiveJob::TestHelper
  let(:question) { create :question, :with_categories }
  let(:subscriber) { create :user, subscription_categories: question.categories }

  describe '#perform_later' do
    subject(:job) { described_class.perform_later(question.id, subscriber.id) }

    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(question.id, subscriber.id).on_queue('runners_notifiers')
    end
  end

  describe '#perform_now' do
    context 'when valid parameters were passed' do
      subject(:job) { described_class.perform_now(question.id, subscriber.id) }

      let(:mailer) { double('QuestionMailer') }

      it 'calls on QuestionMailer' do
        allow(QuestionMailer).to receive(:with).with(hash_including(question: question,
                                                                    user: subscriber)).and_return(mailer)

        expect(mailer).to receive_message_chain(:notify_subscriber_about_new_question_in_category,
                                                :deliver_now)
        subject
      end
    end

    context 'when invalid parameters were passed' do
      it 'does not call on QuestionMailer with non existing subscriber' do
        expect(QuestionMailer).not_to receive(:with)
        described_class.perform_now(question.id, 999)
      end

      it 'does not call on QuestionMailer with non existing question' do
        expect(QuestionMailer).not_to receive(:with)
        described_class.perform_now(999, subscriber.id)
      end
    end
  end
end
