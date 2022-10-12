# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Question, type: :model do
  context 'when valid attributes' do
    subject(:question) { build :question, :with_categories }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    subject(:question) { build :question, :with_categories, **attrs }

    let(:attrs) { { title: nil, body: nil, user: nil, categories_count: 0 } }

    include_examples 'invalid object'

    it_behaves_like 'with errors' do
      let(:attr) { :title }
      let(:errors) { ['can\'t be blank', 'is too short (minimum is 2 characters)'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :body }
      let(:errors) { ['can\'t be blank', 'is too short (minimum is 2 characters)'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :user }
      let(:errors) { ['must exist'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :categories }
      let(:errors) { ['can\'t be blank'] }
    end
  end

  describe 'associations' do
    subject(:question) { create :question, user: user, categories: [category] }

    before { create :subscription, user: user, category: category }

    let(:category) { create :category }
    let(:answer) { create :answer, repliable: question }
    let(:question_category) { QuestionCategory.find_by(question: question, category: category) }
    let(:user) { create :user }

    it 'has a user' do
      expect(question.user).to eq(user)
    end

    it 'has categories' do
      expect(question.categories).to contain_exactly(category)
    end

    it 'has answers' do
      expect(question.answers).to contain_exactly(answer)
    end

    it 'has question_categories' do
      expect(question.question_categories).to contain_exactly(question_category)
    end

    it 'has subscribers' do
      expect(question.subscribers).to contain_exactly(user)
    end
  end
end
