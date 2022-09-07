require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:category) { create :category }
  let(:question) { build :question, category_ids: [category.id] }

  it 'is valid with valid attributes' do
    expect(question).to be_valid
  end

  it 'is not valid without a title' do
    question.title = nil
    expect(question).to_not be_valid
  end

  it 'is not valid without a body' do
    question.body = nil
    expect(question).to_not be_valid
  end

  it 'is not valid without a category' do
    question.category_ids = nil
    expect(question).to_not be_valid
  end
end
