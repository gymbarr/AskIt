require 'rails_helper'

RSpec.describe SubscriptionMailSender, type: :model do
  describe '#call', :fast do
    let(:question) { create :question }

    it 'enqueues job for notifying subscribers' do
      expect do
        described_class.call(question)
      end.to have_enqueued_job(NotifySubscribersJob).with(question).on_queue('default')
    end
  end
end
