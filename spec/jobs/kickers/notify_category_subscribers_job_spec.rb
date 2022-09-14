require 'rails_helper'

RSpec.describe Kickers::NotifyCategorySubscribersJob, type: :job do
  include ActiveJob::TestHelper
  subject(:question) { create :question, subscribers_per_category: 5 }
  subject(:job) { described_class.perform_later(question.id) }

  context '#perform_later' do
    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(question.id).on_queue('default')
    end
  end

  context '#perform_now' do
    it 'calls on NotifyCategorySubscriberJob' do
      expect(Runners::NotifyCategorySubscriberJob).to receive(:perform_later).exactly(5).times
      perform_enqueued_jobs { job }
    end
  end
end
