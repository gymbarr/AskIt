require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe QuestionCategory, type: :model do
  context 'when valid attributes' do
    subject(:question_category) { build :question_category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { question: nil, category: nil } }
    subject(:question_category) { build :question_category, **attrs }

    it_behaves_like 'with errors' do
      let(:attr) { :question }
      let(:errors) { ['must exist'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :category }
      let(:errors) { ['must exist'] }
    end
  end

  describe 'associations' do
    let(:category) { create :category }
    let(:question) { create :question, categories: [category] }
    subject(:question_category) { QuestionCategory.find_by(question: question, category: category) }

    it 'has a question' do
      expect(subject.question).to eq(question)
    end

    it 'has a category' do
      expect(subject.category).to eq(category)
    end
  end

  describe 'associations' do
    let(:category) { create :category }
    let(:question) { create :question, categories: [category] }
    let(:question_category) { QuestionCategory.find_by(question: question, category: category) }

    it 'has a question' do
      expect(question_category.question).to eq(question)
    end

    it 'has a category' do
      expect(question_category.category).to eq(category)
    end
  end
end
