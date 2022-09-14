require 'rails_helper'

RSpec.describe Comments::Notifiers::NewCommentNotifier, type: :model do
  describe '#call' do
    context 'when replier and the user of the repliable are different users' do
      let(:answer) { create :answer }
      let(:comment) { create :comment, repliable: answer, parent: answer }

      it 'enqueues job NotifyUserAboutNewCommentJob' do
        expect do
          described_class.call(comment)
        end.to have_enqueued_job(Runners::NotifyUserAboutNewCommentJob).with(comment.id).on_queue('notifiers')
      end
    end

    context 'when replier and the user of the repliable are the same users' do
      let(:answer) { create :answer }
      let(:comment) { create :comment, repliable: answer, parent: answer, user: answer.user }

      it 'returns nil' do
        expect(described_class).to receive(:call).with(comment).and_return(nil)
        described_class.call(comment)
      end
    end
  end
end
