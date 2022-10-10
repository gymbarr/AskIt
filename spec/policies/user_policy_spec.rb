require 'rails_helper'
require 'policies/shared_examples/authentication_spec'

RSpec.describe UserPolicy do
  subject { described_class.new(user, user) }
  let(:user) { create :user }

  context 'being an authenticated user' do
    it { is_expected.to permit_actions(%i[change_locale]) }
  end

  context 'being a not authenticated user' do
    subject { described_class.new(nil, user) }

    include_examples 'not authenticated user'
  end
end
