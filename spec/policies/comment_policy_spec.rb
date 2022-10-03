require 'rails_helper'
require 'policies/shared_examples/authentication_spec'

RSpec.describe CommentPolicy do
  subject { described_class.new(user, comment) }

  context 'being an author of the comment' do
    let(:user) { create :user }
    let(:comment) { create :comment, user: user }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end

  context 'being an administrator' do
    let(:user) { create :user, :with_admin_role }
    let(:comment) { create :comment }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end

  context 'being not an administrator and not an author of the comment' do
    let(:user) { create :user }
    let(:comment) { create :comment }

    it { is_expected.to permit_actions(%i[create]) }
    it { is_expected.to forbid_actions(%i[update destroy]) }
  end

  context 'being a not authenticated user' do
    subject { described_class.new(nil, comment) }
    let(:comment) { create :comment }

    include_examples 'not authenticated user'
  end
end
