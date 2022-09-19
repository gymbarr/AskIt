require 'rails_helper'

RSpec.describe Answer, type: :model do
  shared_examples 'valid object' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(subject).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      subject.valid?
      expect(subject.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    subject(:answer) { build :answer }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { body: nil, user: nil, repliable: nil } }
    subject(:answer) { build :answer, **attrs }

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

  describe 'associations' do
    let(:user) { create :user }
    let(:question) { create :question, :with_categories }
    let(:answer) { create :answer, user: user, repliable: question }
    let(:comment) { create :comment, repliable: answer }

    it 'has a user' do
      expect(answer.user).to eq(user)
    end

    it 'has a repliable' do
      expect(answer.repliable).to eq(question)
    end

    it 'has comments' do
      expect(answer.comments).to contain_exactly(comment)
    end
  end
end
