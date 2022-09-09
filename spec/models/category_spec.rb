require 'rails_helper'

RSpec.describe Category, type: :model do
  shared_examples 'valid object' do
    it 'is valid' do
      expect(category).to be_valid
    end
  end

  shared_examples 'invalid object' do
    it 'is invalid' do
      expect(category).to_not be_valid
    end
  end

  shared_examples 'with error' do
    it 'has error' do
      category.valid?
      expect(category.errors[attr]).to eq(error)
    end
  end

  context 'when valid attributes' do
    let(:category) { build :category }

    include_examples 'valid object'
  end

  context 'when invalid attributes' do
    let(:attrs) { { name: nil } }
    let(:category) { build :category, **attrs }

    include_examples 'invalid object'

    include_examples 'with error' do
      let(:attr) { :name }
      let(:error) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
    end
  end

  context 'when attributes are not unique' do
    let(:category2) { create :category }
    let(:attrs) { { name: category2.name } }
    let(:category) { build :category, **attrs }

    include_examples 'with error' do
      let(:attr) { :name }
      let(:error) { ['has already been taken'] }
    end
  end
end
