require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Comment, type: :model do
  let(:answer) { create :answer }

  context 'when valid attributes' do
    subject(:comment) { build :comment, repliable: answer }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { body: nil, user: nil, repliable: nil, parent: nil } }
    subject(:comment) { build :comment, **attrs }

    include_examples 'invalid object'

    it_behaves_like 'with errors' do
      let(:attr) { :body }
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

    it_behaves_like 'with errors' do
      let(:attr) { :ancestry }
      let(:errors) { ['can\'t be blank'] }
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

  context 'associations' do
    let(:comment_for_answer) { create :comment, repliable: answer, parent: answer }
    let(:comment_for_comment) do
      create :comment,
             :for_comment,
             repliable: comment_for_answer,
             parent: comment_for_answer
    end

    it 'has a user' do
      expect(comment_for_answer.user).to be_instance_of(User)
    end

    it 'has a comment' do
      expect(comment_for_answer.comments).to all(be_an(Comment))
    end

    it 'has an answer as a repliable' do
      expect(comment_for_answer.repliable).to be_an_instance_of(Answer)
    end

    it 'has an answer as a parent' do
      expect(comment_for_answer.parent).to be_an_instance_of(Answer)
    end

    it 'has a comment as a repliable' do
      expect(comment_for_comment.repliable).to be_an_instance_of(Comment)
    end

    it 'has a comment as a parent' do
      expect(comment_for_comment.parent).to be_an_instance_of(Comment)
    end
  end
end
