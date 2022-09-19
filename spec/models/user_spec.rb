require 'rails_helper'

RSpec.describe User, type: :model do
  shared_examples 'valid object' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(user).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      user.valid?
      expect(user.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:user) { build :user }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { username: nil, email: nil, password: nil } }
    let(:user) { build :user, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with error' do
      let(:attr) { :username }
      let(:error) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :email }
      let(:error) { ['can\'t be blank'] }
    end
  end

  context 'when attributes are not unique' do
    let(:user2) { create :user }
    let(:attrs) { { username: user2.username, email: user2.email } }
    let(:user) { build :user, **attrs }

    it_behaves_like 'with error' do
      let(:attr) { :username }
      let(:error) { ['has already been taken'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :email }
      let(:error) { ['has already been taken'] }
    end
  end

  describe 'associations' do
    let(:user) { create :user }
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
  end
end
