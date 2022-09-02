require 'rails_helper'

RSpec.describe NotifySubscribersJob, type: :job do
  let(:question) { create :question }
  let(:category) { create :category, :with_subscribers, count: 10 }
  let(:question_category) { create :question_category, question_id: question.id, category_id: category.id }

  describe '#perform_later', :fast do
    it 'matches with enqueued job' do
      question_category
      expect do
        described_class.perform_later(question)
      end.to have_enqueued_job(described_class).with(question).on_queue('default')
    end

    it 'performs notify job for every subscriber' do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      question_category
      expect do
        described_class.perform_later(question)
      end.to have_performed_job(NotifySubscriberJob).at_least(category.subscribers.count).times
    end

    it 'performs notify job for every subscriber except the question author' do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      question_category
      category.subscribers << question.user
      expect do
        described_class.perform_later(question)
      end.to have_performed_job(NotifySubscriberJob).at_least(category.subscribers.count - 1).times
    end

    it 'do not performs notify job for question without category' do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      expect do
        described_class.perform_later(question)
      end.to have_performed_job(NotifySubscriberJob).at_least(0).times
    end

    it 'do not performs notify job for question without subscibers' do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      category.subscribers.destroy_all
      expect do
        described_class.perform_later(question)
      end.to have_performed_job(NotifySubscriberJob).at_least(0).times
    end
  end
end
