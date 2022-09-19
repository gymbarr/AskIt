require 'rails_helper'

RSpec.describe Subscription, type: :model do
  shared_examples 'valid object' do
    it 'is valid' do
      expect(subscription).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(subscription).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      subscription.valid?
      expect(subscription.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:subscription) { build :subscription }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { user: nil, category: nil } }
    let(:subscription) { build :subscription, **attrs }

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
