# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe QuestionCategory, type: :model do
  context 'when valid attributes' do
    subject(:question_category) { build :question_category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    subject(:question_category) { build :question_category, **attrs }

    let(:attrs) { { question: nil, category: nil } }

    include_examples 'invalid object'

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
    subject(:question_category) { described_class.find_by(question: question, category: category) }

    let(:category) { create :category }
    let(:question) { create :question, categories: [category] }

    it 'has a question' do
      expect(subject.question).to eq(question)
    end

    it 'has a category' do
      expect(subject.category).to eq(category)
    end
  end
end
