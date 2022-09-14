require 'rails_helper'

RSpec.describe Runners::NotifyCategorySubscriberJob, type: :job do
  include ActiveJob::TestHelper
  subject(:question) { create :question }
  subject(:subscriber) { create :user, subscription_categories: question.categories }
  subject(:job) { described_class.perform_later(question.id, subscriber.id) }

  context '#perform_later' do
    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(question.id, subscriber.id).on_queue('notifiers')
    end
  end

  context '#perform_now' do
    it 'calls on QuestionMailer' do
      expect(QuestionMailer).to receive_message_chain(:with,
                                                      :notify_subscriber_about_new_question_in_category,
                                                      :deliver_now)
      perform_enqueued_jobs { job }
    end
  end
end
