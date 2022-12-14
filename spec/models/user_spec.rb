# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe User, type: :model do
  context 'when valid attributes' do
    subject(:user) { build :user }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    subject(:user) { build :user, **attrs }

    let(:attrs) { { username: nil, email: nil, password: nil, roles: [] } }

    include_examples 'invalid object'

    it_behaves_like 'with errors' do
      let(:attr) { :username }
      let(:errors) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :email }
      let(:errors) { ['can\'t be blank'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :password }
      let(:errors) { ['can\'t be blank'] }
    end
  end

  context 'when attributes are not unique' do
    subject(:user) { build :user, **attrs }

    let(:user2) { create :user }
    let(:attrs) { { username: user2.username, email: user2.email } }

    it_behaves_like 'with errors' do
      let(:attr) { :username }
      let(:errors) { ['has already been taken'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :email }
      let(:errors) { ['has already been taken'] }
    end
  end

  context 'when invalid attributes on update' do
    subject(:user) { create :user }

    it_behaves_like 'with errors on update' do
      let(:attr) { :roles }
      let(:errors) { ['can\'t be blank'] }
    end
  end

  describe 'associations' do
    subject(:user) { create :user, roles: [role] }

    let(:role) { create :role }
    let(:question) { create :question, :with_categories, user: user }
    let(:answer) { create :answer, user: user, repliable: question }
    let(:comment) { create :comment, user: user, repliable: answer }
    let(:category) { create :category }
    let!(:subscription) { create :subscription, user: user, category: category }

    it 'has questions' do
      expect(user.questions).to contain_exactly(question)
    end

    it 'has answers as replies' do
      expect(user.replies).to include(answer)
    end

    it 'has comments as replies' do
      expect(user.replies).to include(comment)
    end

    it 'has subscriptions' do
      expect(user.subscriptions).to contain_exactly(subscription)
    end

    it 'has subscription_categories' do
      expect(user.subscription_categories).to contain_exactly(category)
    end

    it 'has roles' do
      expect(user.roles).to contain_exactly(role)
    end
  end
end
