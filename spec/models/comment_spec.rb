require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:category) { create :category }
  let(:question) { create :question, categories: [category] }
  let(:answer) { create :answer, repliable: question }

  describe 'for answer' do
    let(:comment_for_answer) { build :comment, repliable: answer, parent: answer }

    it 'is valid with valid attributes' do
      expect(comment_for_answer).to be_valid
    end

    it 'is not valid without a body' do
      comment_for_answer.body = nil
      expect(comment_for_answer).to_not be_valid
    end

    it 'is not valid without a repliable' do
      comment_for_answer.repliable = nil
      expect(comment_for_answer).to_not be_valid
    end

    it 'is not valid without an ancestry' do
      comment_for_answer.parent = nil
      expect(comment_for_answer).to_not be_valid
    end
  end

  describe 'for comment' do
    let(:comment_for_answer) { create :comment, repliable: answer, parent: answer }
    let(:comment_for_comment) do
      build :comment,
            :for_comment,
            repliable: comment_for_answer,
            parent: comment_for_answer
    end

    it 'is valid with valid attributes' do
      expect(comment_for_comment).to be_valid
    end

    it 'is not valid without a body' do
      comment_for_comment.body = nil
      expect(comment_for_comment).to_not be_valid
    end

    it 'is not valid without a repliable' do
      comment_for_comment.repliable = nil
      expect(comment_for_comment).to_not be_valid
    end

    it 'is not valid without an ancestry' do
      comment_for_comment.parent = nil
      expect(comment_for_comment).to_not be_valid
    end
  end
end
