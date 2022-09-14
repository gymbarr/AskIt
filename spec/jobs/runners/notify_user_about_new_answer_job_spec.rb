require 'rails_helper'

RSpec.describe Runners::NotifyUserAboutNewAnswerJob, type: :job do
  include ActiveJob::TestHelper
  subject(:answer) { create :answer }
  subject(:job) { described_class.perform_later(answer.id) }

  context '#perform_later' do
    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(answer.id).on_queue('notifiers')
    end
  end

  context '#perform_now' do
    it 'calls on QuestionMailer' do
      expect(AnswerMailer).to receive_message_chain(:with,
                                                    :notify_user_about_new_answer,
                                                    :deliver_now)
      perform_enqueued_jobs { job }
    end
  end
end
