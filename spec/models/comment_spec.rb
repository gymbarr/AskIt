require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:category) { create :category }
  let(:question) { create :question, category_ids: [category.id] }
  let(:answer) { build :answer, repliable: question }
  let(:comment) { build :comment, repliable: answer }

  it 'is valid with valid attributes' do
    debugger
    expect(comment).to be_valid
  end

  it 'is not valid without a body' do
    comment.body = nil
    expect(comment).to_not be_valid
  end

  it 'is not valid without a repliable' do
    comment.repliable = nil
    expect(comment).to_not be_valid
  end

  # it 'is not valid without an ancestry' do
  #   comment.repliable = nil
  #   expect(comment).to_not be_valid
  # end
end
