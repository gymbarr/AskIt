require 'rails_helper'

RSpec.describe Answers::Notifiers::NewAnswerNotifier, type: :model do
  describe '.call' do
    context 'when replier and the user of the repliable are different users' do
      let(:answer) { create :answer }
      subject(:service) { described_class.call(answer) }

      it 'enqueues job NotifyUserAboutNewAnswerJob' do
        expect { subject }
          .to have_enqueued_job(Runners::NotifyUserAboutNewAnswerJob).with(answer.id).on_queue('notifiers')
      end
    end

    context 'when replier and the user of the repliable are the same users' do
      let(:question) { create :question }
      let(:answer) { create :answer, user: question.user }

      it 'returns nil' do
        expect(described_class).to receive(:call).with(answer).and_return(nil)
        described_class.call(answer)
      end
    end
  end
end
