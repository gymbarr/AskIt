# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Notifiers::NewCommentNotifier, type: :model do
  describe '.call' do
    subject(:service) { described_class.call(comment) }

    context 'when replier and the user of the repliable are different users' do
      let(:answer) { create :answer }
      let(:comment) { create :comment, repliable: answer }

      it 'enqueues job NotifyUserAboutNewCommentJob' do
        expect { subject }
          .to have_enqueued_job(Runners::NotifyUserAboutNewCommentJob).with(comment.id).on_queue('runners_notifiers')
      end
    end

    context 'when replier and the user of the repliable are the same users' do
      let(:answer) { create :answer }
      let(:comment) { create :comment, repliable: answer, user: answer.user }

      it 'does not enqueue job NotifyUserAboutNewCommentJob' do
        expect { subject }.not_to have_enqueued_job(Runners::NotifyUserAboutNewCommentJob)
      end
    end
  end
end
