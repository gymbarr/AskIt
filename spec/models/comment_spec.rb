require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:answer) { create :answer }

  shared_examples 'valid object' do
    it 'is valid' do
      expect(comment).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(comment).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      comment.valid?
      expect(comment.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:comment) { build :comment, repliable: answer }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { body: nil, user: nil, repliable: nil, parent: nil } }
    let(:comment) { build :comment, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with error' do
      let(:attr) { :body }
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

    it_behaves_like 'with error' do
      let(:attr) { :ancestry }
      let(:error) { ['can\'t be blank'] }
    end
  end

  describe 'associations' do
    let(:user) { create :user }
    let(:comment_for_answer) { create :comment, user: user, repliable: answer }
    let(:comment_for_comment) do
      create :comment,
             :for_comment,
             repliable: comment_for_answer
    end

    it 'has a user' do
      expect(comment_for_answer.user).to eq(user)
    end

    it 'has a comment' do
      expect(comment_for_answer.comments).to contain_exactly(comment_for_comment)
    end

    context 'when comment for answer' do
      it 'has an answer as a repliable' do
        expect(comment_for_answer.repliable).to eq(answer)
      end

      it 'has an answer as a parent' do
        expect(comment_for_answer.parent).to eq(answer)
      end
    end

    context 'when comment for comment' do
      it 'has a comment as a repliable' do
        expect(comment_for_comment.repliable).to eq(comment_for_answer)
      end

      it 'has a comment as a parent' do
        expect(comment_for_comment.parent).to eq(comment_for_answer)
      end
    end
  end
end
