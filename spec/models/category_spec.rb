require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Category, type: :model do
  context 'when valid attributes' do
    subject(:category) { build :category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { name: nil } }
    subject(:category) { build :category, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with errors' do
      let(:attr) { :name }
      let(:errors) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
    end
  end

  context 'when attributes are not unique' do
    let(:category2) { create :category }
    let(:attrs) { { name: category2.name } }
    subject(:category) { build :category, **attrs }

    it_behaves_like 'with errors' do
      let(:attr) { :name }
      let(:errors) { ['has already been taken'] }
    end
  end

  describe 'associations' do
    subject(:category) { create :category }
    let(:subscription) { create :subscription, category: category }
    let(:question) { create :question, categories: [category] }
    let(:question_category) { QuestionCategory.find_by(question: question, category: category) }
    let(:subscriber) { subscription.user }

    it 'has question_categories' do
      expect(subject.question_categories).to contain_exactly(question_category)
    end

    it 'has questions' do
      expect(subject.questions).to contain_exactly(question)
    end

    it 'has subscriptions' do
      expect(subject.subscriptions).to contain_exactly(subscription)
    end

    it 'has subscribers' do
      expect(subject.subscribers).to contain_exactly(subscriber)
    end
  end

  context 'associations' do
    let(:category) { create :category_with_questions, questions_count: 10, subscribers_count: 10 }

    it 'has question_categories' do
      expect(category.question_categories.size).to eq(10)
      expect(category.question_categories).to all(be_an(QuestionCategory))
    end

    it 'has questions' do
      expect(category.questions.size).to eq(10)
      expect(category.questions).to all(be_an(Question))
    end

    it 'has subscriptions' do
      expect(category.subscriptions.size).to eq(10)
      expect(category.subscriptions).to all(be_an(Subscription))
    end

    it 'has subscribers' do
      expect(category.subscribers.size).to eq(10)
      expect(category.subscribers).to all(be_an(User))
    end
  end
end
