# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Category, type: :model do
  context 'when valid attributes' do
    subject(:category) { build :category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    subject(:category) { build :category, **attrs }

    let(:attrs) { { name: nil } }

    include_examples 'invalid object'

    it_behaves_like 'with errors' do
      let(:attr) { :name }
      let(:errors) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
    end
  end

  context 'when attributes are not unique' do
    subject(:category) { build :category, **attrs }

    let(:category2) { create :category }
    let(:attrs) { { name: category2.name } }

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
