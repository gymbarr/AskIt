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
    subject(:job) { described_class.perform_later(question.id, subscriber.id) }

    it 'calls on QuestionMailer' do
      expect(QuestionMailer).to receive_message_chain(:with,
                                                      :notify_subscriber_about_new_question_in_category,
                                                      :deliver_now)
      perform_enqueued_jobs { job }
    end
  end
end
