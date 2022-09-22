require 'rails_helper'

RSpec.describe Runners::NotifyUserAboutNewAnswerJob, type: :job do
  include ActiveJob::TestHelper
  let(:question) { create :question, :with_categories }
  let(:answer) { create :answer, repliable: question }

  describe '#perform_later' do
    subject(:job) { described_class.perform_later(answer.id) }

    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(answer.id).on_queue('notifiers')
    end
  end

  describe '#perform_now' do
    context 'when valid parameters were passed' do
      subject(:job) { described_class.perform_now(answer.id) }

      it 'calls on AnswerMailer' do
        allow(AnswerMailer).to receive_message_chain(:with,
                                                     :notify_user_about_new_answer,
                                                     :deliver_now)
        subject
        expect(AnswerMailer).to have_received(:with).with(question: question,
                                                          user: question.user,
                                                          replier: answer.user)
      end
    end

    context 'when invalid parameters were passed' do
      it 'does not call on AnswerMailer with non existing answer' do
        allow(AnswerMailer).to receive_message_chain(:with,
                                                     :notify_user_about_new_answer,
                                                     :deliver_now)
        described_class.perform_now(999)
        expect(AnswerMailer).not_to have_received(:with)
      end
    end
  end
end
