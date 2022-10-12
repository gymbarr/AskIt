# frozen_string_literal: true

require 'rails_helper'
require 'policies/shared_examples/authentication_spec'

RSpec.describe QuestionPolicy do
  subject { described_class.new(user, question) }

  context 'being an author of the question' do
    let(:user) { create :user }
    let(:question) { create :question, :with_categories, user: user }

    it { is_expected.to permit_actions(%i[index show new create edit update destroy vote_up vote_down]) }
  end

  context 'being an administrator' do
    let(:user) { create :user, :with_admin_role }
    let(:question) { create :question, :with_categories }

    it { is_expected.to permit_actions(%i[index show new create edit update destroy vote_up vote_down]) }
  end

  context 'being not an administrator and not an author of the question' do
    let(:user) { create :user }
    let(:question) { create :question, :with_categories }

    it { is_expected.to permit_actions(%i[index show new create vote_up vote_down]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end

  context 'being a not authenticated user' do
    subject { described_class.new(nil, question) }

    let(:question) { create :question, :with_categories }

    include_examples 'not authenticated user'
  end
end
