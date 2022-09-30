require 'rails_helper'

RSpec.describe AnswerPolicy do
  subject { described_class.new(user, answer) }

  context 'being an author of the answer' do
    let(:user) { create :user }
    let(:answer) { create :answer, user: user }

    it { is_expected.to permit_actions(%i[create update destroy vote_up vote_down]) }
  end

  context 'being an administrator' do
    let(:user) { create :user, :with_admin_role }
    let(:answer) { create :answer }

    it { is_expected.to permit_actions(%i[create update destroy vote_up vote_down]) }
  end

  context 'being not an administrator and not an author of the answer' do
    let(:user) { create :user }
    let(:answer) { create :answer }

    it { is_expected.to permit_actions(%i[create vote_up vote_down]) }
    it { is_expected.to forbid_actions(%i[update destroy]) }
  end
end
