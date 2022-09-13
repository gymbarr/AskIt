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
      debugger
      expect(comment.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:comment) { build :comment, repliable: answer, parent: answer }

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
