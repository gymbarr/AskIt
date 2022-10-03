require 'rails_helper'

shared_examples 'not authenticated user' do
  it 'raise NotAuthorizedError' do
    expect { subject }.to raise_error(Pundit::NotAuthorizedError)
  end
end
