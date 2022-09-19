require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Subscription, type: :model do
  context 'when valid attributes' do
    subject(:subscription) { build :subscription }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { user: nil, category: nil } }
    subject(:subscription) { build :subscription, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with error' do
      let(:attr) { :user }
      let(:error) { ['must exist'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :category }
      let(:error) { ['must exist'] }
    end
  end

  describe 'associations' do
    let(:user) { create :user }
    let(:category) { create :category }
    let(:subscription) { create :subscription, user: user, category: category }

    it 'has a user' do
      expect(subscription.user).to eq(user)
    end

    it 'has a category' do
      expect(subscription.category).to eq(category)
    end
  end
end
