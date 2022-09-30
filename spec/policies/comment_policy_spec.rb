require 'rails_helper'

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
end
