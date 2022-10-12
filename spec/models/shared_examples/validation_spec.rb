require 'rails_helper'

shared_examples 'valid object' do
  it 'is valid' do
    expect(subject).to be_valid
  end
end

shared_examples 'invalid object' do
  it 'is invalid' do
    expect(subject).not_to be_valid
  end
end

shared_examples 'with errors' do
  it 'has errors' do
    subject.valid?
    expect(subject.errors[attr]).to eq(errors)
  end
end

shared_examples 'with errors on update' do
  it 'has errors' do
    subject.send(attr).clear
    subject.valid?
    expect(subject.errors[attr]).to eq(errors)
  end
end
