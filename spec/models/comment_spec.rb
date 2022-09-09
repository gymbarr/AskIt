require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:category) { create :category }
  let(:question) { create :question, categories: [category] }
  let(:answer) { create :answer, repliable: question }
  let(:comment_for_answer) { create :comment, repliable: answer, parent: answer }

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
    describe 'for answer' do
      let(:attrs) { { repliable: answer, parent: answer } }
      let(:comment) { build :comment, **attrs }

      include_examples 'valid object'

      it 'has user' do
        expect(comment.user).to be_instance_of(User)
      end

      it 'has repliable' do
        expect(comment.repliable).to eq(answer)
      end

      it 'has parent' do
        expect(comment.parent).to eq(answer)
      end
    end

    describe 'for comment' do
      let(:attrs) { { repliable: comment_for_answer, parent: comment_for_answer } }
      let(:comment) { build :comment, **attrs }

      include_examples 'valid object'

      it 'has user' do
        expect(comment.user).to be_instance_of(User)
      end

      it 'has repliable' do
        expect(comment.repliable).to eq(comment_for_answer)
      end

      it 'has parent' do
        expect(comment.parent).to eq(comment_for_answer)
      end
    end
  end

  context 'when invalid attributes' do
    let(:attrs) { { body: nil, user: nil, repliable: nil, parent: nil } }
    let(:comment) { build :comment, **attrs }

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

    include_examples 'with error' do
      let(:attr) { :ancestry }
      let(:error) { ['can\'t be blank'] }
    end
  end
end
