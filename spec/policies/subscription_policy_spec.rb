require 'rails_helper'

RSpec.describe SubscriptionPolicy do
  subject { described_class.new(user, subscription) }

  context 'being an authenticated user' do
    let(:user) { create :user }
    let(:category) { create :category }
    let(:subscription) { create :subscription, user: user, category: category }

    it { is_expected.to permit_actions(%i[create destroy]) }
  end
end
