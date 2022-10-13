# frozen_string_literal: true

require 'rails_helper'
require 'policies/shared_examples/authentication_spec'

RSpec.describe SubscriptionPolicy do
  subject { described_class.new(user, subscription) }

  context 'when the user is an authenticated user' do
    let(:user) { create :user }
    let(:subscription) { create :subscription, user: user }

    it { is_expected.to permit_actions(%i[create destroy]) }
  end

  context 'when the user not authenticated' do
    subject { described_class.new(nil, subscription) }

    let(:subscription) { create :subscription }

    include_examples 'not authenticated user'
  end
end
