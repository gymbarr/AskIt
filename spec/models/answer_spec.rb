# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Answer, type: :model do
  context 'when valid attributes' do
    subject(:answer) { build :answer }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    subject(:answer) { build :answer, **attrs }

    let(:attrs) { { body: nil, user: nil, repliable: nil } }

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
  end

  describe 'associations' do
    subject(:answer) { create :answer, user: user, repliable: question }

    let(:user) { create :user }
    let(:comment) { create :comment, repliable: answer }
    let(:question) { create :question, :with_categories }

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
