require 'rails_helper'

RSpec.describe Kickers::NotifyCategorySubscribersJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform_later' do
    let(:question) { create :question, :with_categories, subscribers_per_category: 5 }
    subject(:job) { described_class.perform_later(question.id) }

    it 'matches with enqueued job' do
      expect { subject }
        .to have_enqueued_job(described_class).with(question.id).on_queue('kickers_notifiers')
    end
  end

  describe '#perform_now' do
    context 'when valid parameters were passed' do
      subject(:job) { described_class.perform_now(question.id) }
      let(:question) { create :question, :with_categories, subscribers_per_category: 5 }

      it 'calls on NotifyCategorySubscriberJob for all subscribers' do
        expect { subject }
          .to have_enqueued_job(Runners::NotifyCategorySubscriberJob).exactly(5)
                                                                     .times
                                                                     .with do |question_id, subscriber_id|
          expect(question_id).to eq(question.id)
          question.subscribers.each do |subscriber|
            expect(subscriber_id).to eq(subscriber.id)
          end
        end
      end
    end

    context 'when invalid parameters were passed' do
      let(:question) { create :question, :with_categories }

      it 'does not enqueue NotifyCategorySubscriberJob with non existing question' do
        described_class.perform_now(999)
        expect(Runners::NotifyCategorySubscriberJob).not_to have_been_enqueued
      end
    end

    context 'when invalid parameters inside the method were found' do
      let(:question) { create :question, :with_categories, subscribers_per_category: 0 }

      it 'does not enqueue NotifyCategorySubscriberJob with non existing subscribers' do
        described_class.perform_now(question.id)
        expect(Runners::NotifyCategorySubscriberJob).not_to have_been_enqueued
      end
    end
  end
end
