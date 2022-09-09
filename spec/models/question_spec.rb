require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:category) { create :category }

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
    let(:attrs) { { categories: [category] } }
    let(:question) { build :question, **attrs }

    include_examples 'valid object'

    it 'has user' do
      expect(question.user).to be_instance_of(User)
    end

    it 'has categories' do
      expect(question.categories).to contain_exactly(category)
    end
  end

  context 'when invalid attributes' do
    let(:attrs) { { title: nil, body: nil, user: nil } }
    let(:question) { build :question, **attrs }

    include_examples 'invalid object'

    include_examples 'with error' do
      let(:attr) { :title }
      let(:error) { ['can\'t be blank', 'is too short (minimum is 2 characters)'] }
    end

    include_examples 'with error' do
      let(:attr) { :body }
      let(:error) { ['can\'t be blank', 'is too short (minimum is 2 characters)'] }
    end

    include_examples 'with error' do
      let(:attr) { :user }
      let(:error) { ['can\'t be blank'] }
    end

    include_examples 'with error' do
      let(:attr) { :categories }
      let(:error) { ['can\'t be blank'] }
    end
  end
end
