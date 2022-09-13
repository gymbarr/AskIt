require 'rails_helper'

RSpec.describe Answer, type: :model do
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
    let(:answer) { build :answer }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { body: nil, user: nil, repliable: nil } }
    let(:answer) { build :answer, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with error' do
      let!(:attr) { :body }
      let(:error) { ['can\'t be blank'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :user }
      let(:error) { ['must exist'] }
    end

    it_behaves_like 'with error' do
      let(:attr) { :repliable }
      let(:error) { ['must exist'] }
    end
  end

  context 'associations' do
    let(:answer) { create :answer_with_comments, comments_count: 10 }

    it 'has a user' do
      expect(answer.user).to be_instance_of(User)
    end

    it 'has a repliable' do
      expect(answer.repliable).to be_instance_of(Question)
    end

    it 'has comments' do
      expect(answer.comments.size).to eq(10)
      expect(answer.comments).to all(be_an(Comment))
    end
  end
end
