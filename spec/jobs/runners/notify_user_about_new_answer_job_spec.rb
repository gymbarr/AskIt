# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Runners::NotifyUserAboutNewAnswerJob, type: :job do
  include ActiveJob::TestHelper
  let(:question) { create :question, :with_categories }
  let(:answer) { create :answer, repliable: question }

  describe '#perform_later' do
    subject(:job) { described_class.perform_later(answer.id) }

    it 'matches with enqueued job' do
      expect { job }
        .to have_enqueued_job(described_class).with(answer.id).on_queue('runners_notifiers')
    end
  end

  describe '#perform_now' do
    context 'when valid parameters were passed' do
      subject(:job) { described_class.perform_now(answer.id) }

      let(:mailer) { double('AnswerMailer') }

      it 'calls on AnswerMailer' do
        allow(AnswerMailer).to receive(:with).with(question: question,
                                                   user: question.user,
                                                   replier: answer.user).and_return(mailer)

        expect(mailer).to receive_message_chain(:notify_user_about_new_answer, :deliver_now)
        subject
      end
    end

    context 'when invalid parameters were passed' do
      it 'does not call on AnswerMailer with non existing answer' do
        expect(AnswerMailer).not_to receive(:with)
        described_class.perform_now(999)
      end
    end
  end
end
