# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answers::Notifiers::NewAnswerNotifier, type: :model do
  describe '.call' do
    subject(:service) { described_class.call(answer) }

    context 'when replier and the user of the repliable are different users' do
      let(:answer) { create :answer }

      it 'enqueues job NotifyUserAboutNewAnswerJob' do
        expect { service }
          .to have_enqueued_job(Runners::NotifyUserAboutNewAnswerJob).with(answer.id).on_queue('runners_notifiers')
      end
    end

    context 'when replier and the user of the repliable are the same users' do
      let(:question) { create :question, :with_categories }
      let(:answer) { create :answer, repliable: question, user: question.user }

      it 'does not enqueue job NotifyUserAboutNewAnswerJob' do
        expect { service }.not_to have_enqueued_job(Runners::NotifyUserAboutNewAnswerJob)
      end
    end
  end
end
