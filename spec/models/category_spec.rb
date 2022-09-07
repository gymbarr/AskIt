require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build :category }
  let(:category2) { create :category }

  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category.name = nil
    expect(category).to_not be_valid
  end

  it 'is not valid without a unique name' do
    category.name = category2.name
    expect(category).to_not be_valid
  end
end
