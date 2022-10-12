require 'rails_helper'

RSpec.describe Questions::Notifiers::CategorySubscribersNotifier, type: :model do
  describe '.call' do
    subject(:service) { described_class.call(question) }

    let(:question) { create :question, :with_categories }

    it 'enqueues job NotifyCategorySubscribersJob' do
      expect { subject }
        .to have_enqueued_job(Kickers::NotifyCategorySubscribersJob).with(question.id).on_queue('kickers_notifiers')
    end
  end
end
