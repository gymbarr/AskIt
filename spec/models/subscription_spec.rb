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

    it_behaves_like 'with errors' do
      let(:attr) { :user }
      let(:errors) { ['must exist'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :category }
      let(:errors) { ['must exist'] }
    end
  end

  describe 'associations' do
    let(:user) { create :user }
    let(:category) { create :category }
    subject(:subscription) { create :subscription, user: user, category: category }

    it 'has a user' do
      expect(subject.user).to eq(user)
    end

    it 'has a category' do
      expect(subject.category).to eq(category)
    end
  end
<<<<<<< HEAD

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
=======
end
>>>>>>> e289848 (correct issues after merge with modify-tests-for-services-jobs-mailers)
