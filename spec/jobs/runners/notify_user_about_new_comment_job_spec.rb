require 'rails_helper'

RSpec.describe Runners::NotifyUserAboutNewCommentJob, type: :job do
  include ActiveJob::TestHelper
  subject(:answer) { create :answer }
  subject(:comment) { create :comment, repliable: answer, parent: answer }
  subject(:job) { described_class.perform_later(comment.id) }

  context '#perform_later' do
    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(comment.id).on_queue('notifiers')
    end
  end

  context '#perform_now' do
    it 'calls on QuestionMailer' do
      expect(CommentMailer).to receive_message_chain(:with,
                                                     :notify_user_about_new_comment,
                                                     :deliver_now)
      perform_enqueued_jobs { job }
    end
  end
end
