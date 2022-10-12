# frozen_string_literal: true

require 'rails_helper'
require 'policies/shared_examples/authentication_spec'

RSpec.describe CategoryPolicy do
  subject { described_class.new(user, category) }

  let(:category) { create :category }

  context 'when the user is an administrator' do
    let(:user) { create :user, :with_admin_role }

    it { is_expected.to permit_actions(%i[index show new create edit update destroy]) }
  end

  context 'when the user is a basic user' do
    let(:user) { create :user }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context 'when the user not authenticated' do
    subject { described_class.new(nil, category) }

    let(:category) { create :category }

    include_examples 'not authenticated user'
  end
end
