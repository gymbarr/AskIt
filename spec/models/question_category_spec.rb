require 'rails_helper'

RSpec.describe QuestionCategory, type: :model do
  shared_examples 'valid object' do
    it 'is valid' do
      expect(question_category).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(question_category).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      question_category.valid?
      expect(question_category.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:question_category) { build :question_category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { question: nil, category: nil } }
    let(:question_category) { build :question_category, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with error' do
      let(:attr) { :question }
      let(:error) { ['must exist'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :category }
      let(:error) { ['must exist'] }
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
