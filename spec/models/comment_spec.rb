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

  # it 'is not valid without a body' do
  #   answer.body = nil
  #   expect(answer).to_not be_valid
  # end

  # it 'is not valid without a repliable' do
  #   answer.repliable = nil
  #   expect(answer).to_not be_valid
  # end
end
