require 'rails_helper'

RSpec.describe NotifySubscriberJob, type: :job do
  subject(:subscriber) { create :user }
  subject(:category) { create :category }
  subject(:question) { create :question }
  subject(:params) { { subscriber: subscriber, category: category, question: question } }

  describe '#perform_later' do
    it 'matches with enqueued job' do
      expect do
        described_class.perform_later(params)
      end.to have_enqueued_job(described_class).with(params).on_queue('default')
    end

    it 'matches with delivered mail job' do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      expect do
        described_class.perform_later(params)
      end.to have_performed_job(ActionMailer::MailDeliveryJob)
    end
  end
end
