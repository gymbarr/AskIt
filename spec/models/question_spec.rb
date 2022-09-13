require 'rails_helper'

RSpec.describe Question, type: :model do
  shared_examples 'valid object' do
    it 'is valid' do
      expect(question).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(question).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      question.valid?
      expect(question.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:question) { build :question }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { title: nil, body: nil, user: nil, categories_count: 0 } }
    let(:question) { build :question, **attrs }

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

  context 'associations' do
    let(:question) do
      create :question_with_answers,
             answers_count: 5,
             categories_count: 5,
             subscribers_per_category: 10
    end

    it 'has a user' do
      expect(question.user).to be_instance_of(User)
    end

    it 'has categories' do
      expect(question.categories.size).to eq(5)
      expect(question.categories).to all(be_an(Category))
    end

    it 'has answers' do
      expect(question.answers.size).to eq(5)
      expect(question.answers).to all(be_an(Answer))
    end

    it 'has question_categories' do
      expect(question.question_categories.size).to eq(5)
      expect(question.question_categories).to all(be_an(QuestionCategory))
    end

    it 'has subscribers' do
      expect(question.subscribers.size).to eq(50)
      expect(question.subscribers).to all(be_an(User))
    end
  end
end
