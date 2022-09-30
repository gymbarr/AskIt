require 'rails_helper'

RSpec.describe QuestionPolicy do
  subject { described_class.new(user, question) }

  let(:article) { Article.create }

  context 'being an owner' do
    let(:user) { create :user }
    let(:question) { create :question, :with_categories, user: user }

    it { is_expected.to permit_actions(%i[index show new create edit update destroy vote_up vote_down]) }
  end

  context 'being an administrator' do
    let(:user) { create :user, :with_admin_role }
    let(:question) { create :question, :with_categories }

    it { is_expected.to permit_actions(%i[index show new create edit update destroy vote_up vote_down]) }
  end

  context 'being not an administrator and not an owner' do
    let(:user) { create :user }
    let(:question) { create :question, :with_categories }

    it { is_expected.to permit_actions(%i[index show new create vote_up vote_down]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end
end
