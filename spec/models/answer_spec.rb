require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:category) { create :category }
  let(:question) { create :question, categories: [category] }

  shared_examples 'valid object' do
    it 'is valid' do
      expect(answer).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(answer).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      answer.valid?
      expect(answer.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:attrs) { { repliable: question } }
    let(:answer) { build :answer, **attrs }

    include_examples 'valid object'

    it 'has user' do
      expect(answer.user).to be_instance_of(User)
    end

    it 'has repliable' do
      expect(answer.repliable).to eq(question)
    end
  end

  context 'when invalid attributes' do
    let(:attrs) { { body: nil, user: nil, repliable: nil } }
    let(:answer) { build :answer, **attrs }

    include_examples 'invalid object'

    include_examples 'with error' do
      let(:attr) { :body }
      let(:error) { ['can\'t be blank'] }
    end

    include_examples 'with error' do
      let(:attr) { :user }
      let(:error) { ['must exist'] }
    end

    include_examples 'with error' do
      let(:attr) { :repliable }
      let(:error) { ['must exist'] }
    end
  end
end
