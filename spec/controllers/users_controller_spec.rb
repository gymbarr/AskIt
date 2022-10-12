# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST /change_locale' do
    subject(:change_locale_request) { post :change_locale, params: { locale: new_locale } }

    let(:old_locale) { 'en' }
    let(:new_locale) { 'ru' }
    let(:user) { create :user, locale: old_locale }

    context 'when authenticated user' do
      it 'changes the users locale' do
        sign_in user

        expect { subject }.to change(user, :locale).from(old_locale).to(new_locale)
        expect(response).to have_http_status(:found)
      end
    end

    context 'when unauthenticated user' do
      it 'blocks unauthenticated access' do
        expect { subject }.not_to change(user, :locale)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
