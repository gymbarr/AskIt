require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Answer, type: :model do
  context 'when valid attributes' do
    subject(:answer) { build :answer }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { body: nil, user: nil, repliable: nil } }
    subject(:answer) { build :answer, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with errors' do
      let!(:attr) { :body }
      let(:errors) { ['can\'t be blank'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :user }
      let(:errors) { ['must exist'] }
    end

    it_behaves_like 'with errors' do
      let(:attr) { :repliable }
      let(:errors) { ['must exist'] }
    end
  end

  describe 'associations' do
    let(:user) { create :user }
    let(:question) { create :question, :with_categories }
    subject(:answer) { create :answer, user: user, repliable: question }
    let(:comment) { create :comment, repliable: answer }

    it 'has a user' do
      expect(subject.user).to eq(user)
    end

    it 'has a repliable' do
      expect(subject.repliable).to eq(question)
    end

    it 'has comments' do
      expect(subject.comments).to contain_exactly(comment)
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
