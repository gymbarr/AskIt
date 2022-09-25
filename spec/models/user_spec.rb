require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe User, type: :model do
  context 'when valid attributes' do
    subject(:user) { build :user }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { username: nil, email: nil, password: nil } }
    subject(:user) { build :user, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with errors' do
      let(:attr) { :username }
      let(:errors) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :email }
      let(:errors) { ['can\'t be blank'] }
    end
  end

  context 'when attributes are not unique' do
    let(:user2) { create :user }
    let(:attrs) { { username: user2.username, email: user2.email } }
    subject(:user) { build :user, **attrs }

    it_behaves_like 'with errors' do
      let(:attr) { :username }
      let(:errors) { ['has already been taken'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :email }
      let(:errors) { ['has already been taken'] }
    end
  end

  describe 'associations' do
    subject(:user) { create :user }
    let(:question) { create :question, :with_categories, user: user }
    let(:answer) { create :answer, user: user, repliable: question }
    let(:comment) { create :comment, user: user, repliable: answer }
    let(:category) { create :category }
    let!(:subscription) { create :subscription, user: user, category: category }

    it 'has questions' do
      expect(subject.questions).to contain_exactly(question)
    end

    it 'has answers as replies' do
      expect(subject.replies).to include(answer)
    end

    it 'has comments as replies' do
      expect(subject.replies).to include(comment)
    end

    it 'has subscriptions' do
      expect(subject.subscriptions).to contain_exactly(subscription)
    end

    it 'has subscription_categories' do
      expect(subject.subscription_categories).to contain_exactly(category)
    end
  end
end
