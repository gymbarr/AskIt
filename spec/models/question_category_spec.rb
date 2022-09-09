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
    let(:category) { create :category }
    let(:question) { create :question, categories: [category] }
    let(:question_category) { build :question_category, question: question, category: category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { question: nil, category: nil } }
    let(:question_category) { build :question_category, **attrs }

    include_examples 'invalid object'

    include_examples 'with error' do
      let(:attr) { :question }
      let(:error) { ['must exist'] }
    end

    include_examples 'with error' do
      let(:attr) { :category }
      let(:error) { ['must exist'] }
    end
  end
end
