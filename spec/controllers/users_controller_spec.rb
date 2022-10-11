require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST /change_locale' do
    let(:user) { create :user, locale: 'en' }
    let(:new_locale) { 'ru' }

    context 'when authenticated user' do
      it 'changes the users locale' do
        sign_in user
        post :change_locale, params: { locale: new_locale }

        expect(user.locale).to eq(new_locale)
        expect(response).to have_http_status(:found)
      end
    end

    context 'when authenticated user' do
      it 'blocks unauthenticated access' do
        sign_in nil
        post :change_locale, params: { locale: new_locale }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
