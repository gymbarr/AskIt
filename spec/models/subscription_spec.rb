# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Subscription, type: :model do
  context 'when valid attributes' do
    subject(:subscription) { build :subscription }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    subject(:subscription) { build :subscription, **attrs }

    let(:attrs) { { user: nil, category: nil } }

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
    subject(:subscription) { create :subscription, user: user, category: category }

    let(:user) { create :user }
    let(:category) { create :category }

    it 'has a user' do
      expect(subscription.user).to eq(user)
    end

    it 'has a category' do
      expect(subscription.category).to eq(category)
    end
  end
end
