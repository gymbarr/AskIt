require 'rails_helper'

RSpec.describe Category, type: :model do
  shared_examples 'valid object' do
    it 'is valid' do
      expect(category).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(category).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      category.valid?
      expect(category.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:category) { build :category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { name: nil } }
    let(:category) { build :category, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with error' do
      let(:attr) { :name }
      let(:error) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
    end
  end

  context 'when attributes are not unique' do
    let(:category2) { create :category }
    let(:attrs) { { name: category2.name } }
    let(:category) { build :category, **attrs }

    it_behaves_like 'with error' do
      let(:attr) { :name }
      let(:error) { ['has already been taken'] }
    end
  end

  describe 'associations' do
    let(:category) { create :category }
    let(:subscription) { create :subscription, category: category }
    let(:question) { create :question, categories: [category] }
    let(:question_category) { QuestionCategory.find_by(question: question, category: category) }
    let(:subscriber) { subscription.user }

    it 'has question_categories' do
      expect(category.question_categories).to contain_exactly(question_category)
    end

    it 'has questions' do
      expect(category.questions).to contain_exactly(question)
    end

    it 'has subscriptions' do
      expect(category.subscriptions).to contain_exactly(subscription)
    end

    it 'has subscribers' do
      expect(category.subscribers).to contain_exactly(subscriber)
    end
  end
end
