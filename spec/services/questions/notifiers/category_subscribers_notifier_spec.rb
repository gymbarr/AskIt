require 'rails_helper'

RSpec.describe Questions::Notifiers::CategorySubscribersNotifier, type: :model do
  describe '#call' do
    let(:question) { create :question }

    it 'enqueues job NotifyCategorySubscribersJob' do
      expect do
        described_class.call(question)
      end.to have_enqueued_job(Kickers::NotifyCategorySubscribersJob).with(question.id).on_queue('default')
    end
  end
end
