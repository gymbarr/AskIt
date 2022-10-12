# frozen_string_literal: true

require 'rails_helper'
require 'policies/shared_examples/authentication_spec'

RSpec.describe AnswerPolicy do
  subject { described_class.new(user, answer) }

  context 'when the user is an author of the answer' do
    let(:user) { create :user }
    let(:answer) { create :answer, user: user }

    it { is_expected.to permit_actions(%i[create update destroy vote_up vote_down]) }
  end

  context 'when the user is an administrator' do
    let(:user) { create :user, :with_admin_role }
    let(:answer) { create :answer }

    it { is_expected.to permit_actions(%i[create update destroy vote_up vote_down]) }
  end

  context 'when the user is not an administrator and not an author of the answer' do
    let(:user) { create :user }
    let(:answer) { create :answer }

    it { is_expected.to permit_actions(%i[create vote_up vote_down]) }
    it { is_expected.to forbid_actions(%i[update destroy]) }
  end

  context 'when the user not authenticated' do
    subject { described_class.new(nil, answer) }

    let(:answer) { create :answer }

    include_examples 'not authenticated user'
  end
end
