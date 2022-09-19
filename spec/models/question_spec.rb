require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Question, type: :model do
  context 'when valid attributes' do
    subject(:question) { build :question, :with_categories }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { title: nil, body: nil, user: nil, categories_count: 0 } }
    subject(:question) { build :question, :with_categories, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with error' do
      let(:attr) { :title }
      let(:error) { ['can\'t be blank', 'is too short (minimum is 2 characters)'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :body }
      let(:error) { ['can\'t be blank', 'is too short (minimum is 2 characters)'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :user }
      let(:error) { ['must exist'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :categories }
      let(:error) { ['can\'t be blank'] }
    end
  end

  describe 'associations' do
    let(:category) { create :category }
    let(:user) { create :user }
    let(:question) { create :question, user: user, categories: [category] }
    let(:answer) { create :answer, repliable: question }
    let(:question_category) { QuestionCategory.find_by(question: question, category: category) }
    let!(:subscription) { create :subscription, user: user, category: category }

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
