require 'rails_helper'
require 'policies/shared_examples/authentication_spec'

RSpec.describe SubscriptionPolicy do
  subject { described_class.new(user, subscription) }

  context 'being an authenticated user' do
    let(:user) { create :user }
    let(:subscription) { create :subscription, user: user }

    it { is_expected.to permit_actions(%i[create destroy]) }
  end

  context 'being a not authenticated user' do
    subject { described_class.new(nil, subscription) }
    let(:subscription) { create :subscription }

    include_examples 'not authenticated user'
  end
end
