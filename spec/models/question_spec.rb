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

    it 'has categories' do
      expect(subject.categories).to contain_exactly(category)
    end

  describe 'associations' do
    let(:category) { create :category }
    let(:user) { create :user }
    subject(:question) { create :question, user: user, categories: [category] }
    let(:answer) { create :answer, repliable: question }
    let(:question_category) { QuestionCategory.find_by(question: question, category: category) }
    let!(:subscription) { create :subscription, user: user, category: category }

    it 'has a user' do
      expect(subject.user).to eq(user)
    end

    it 'has categories' do
      expect(subject.categories).to contain_exactly(category)
    end

    it 'has answers' do
      expect(subject.answers).to contain_exactly(answer)
    end

    it 'has question_categories' do
      expect(subject.question_categories).to contain_exactly(question_category)
    end

    it 'has subscribers' do
      expect(subject.subscribers).to contain_exactly(user)
    end
  end
end
