require 'rails_helper'

RSpec.describe Answers::Notifiers::NewAnswerNotifier, type: :model do
  describe '.call' do
    subject(:service) { described_class.call(answer) }

    context 'when replier and the user of the repliable are different users' do
      let(:answer) { create :answer }

      it 'enqueues job NotifyUserAboutNewAnswerJob' do
        expect { subject }
          .to have_enqueued_job(Runners::NotifyUserAboutNewAnswerJob).with(answer.id).on_queue('notifiers')
      end
    end

    context 'when replier and the user of the repliable are the same users' do
      let(:question) { create :question, :with_categories }
      let(:answer) { create :answer, repliable: question, user: question.user }

      it 'does not enqueue job NotifyUserAboutNewAnswerJob' do
        subject
        expect(Runners::NotifyUserAboutNewAnswerJob).not_to have_been_enqueued
      end
    end
  end
end
