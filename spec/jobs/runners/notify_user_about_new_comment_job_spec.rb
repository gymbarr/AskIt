require 'rails_helper'

RSpec.describe Runners::NotifyUserAboutNewCommentJob, type: :job do
  include ActiveJob::TestHelper
  let(:question) { create :question, :with_categories }
  let(:answer) { create :answer, repliable: question }
  let(:comment) { create :comment, repliable: answer }

  describe '#perform_later' do
    subject(:job) { described_class.perform_later(comment.id) }

    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(comment.id).on_queue('notifiers')
    end
  end

  describe '#perform_now' do
    context 'when valid parameters were passed' do
      subject(:job) { described_class.perform_now(comment.id) }

      it 'calls on CommentMailer' do
        mailer = double('ActionMailer::Parameterized::Mailer')
        allow(CommentMailer).to receive(:with).with(question: question,
                                                    user: answer.user,
                                                    replier: comment.user)
                                              .and_return(mailer)

        expect(mailer).to receive_message_chain(:notify_user_about_new_comment, :deliver_now)
        subject
      end
    end

    context 'when invalid parameters were passed' do
      it 'does not call on CommentMailer with non existing comment' do
        allow(CommentMailer).to receive_message_chain(:with,
                                                      :notify_user_about_new_comment,
                                                      :deliver_now)
        expect(CommentMailer.with(any_args)
                           .notify_user_about_new_comment)
          .not_to receive(:deliver_now)

        described_class.perform_now(999)
      end
    end
  end
end
