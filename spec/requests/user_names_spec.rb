# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/user_names', type: :request do
  let(:user) { create(:user, username: nil) }
  before { sign_in user }

  describe 'GET new' do
    it 'is successful' do
      get new_user_name_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT update' do
    context 'valid params' do
      it 'updated the username' do
        expect do
          put user_name_path(user), params: {
            user: {
              username: 'foobar'
            }
          }
        end.to change { user.reload.username }.from(nil).to('foobar')
        expect(response).to redirect_to(dashboard_path)
      end
    end
    context 'invalid params' do
      it 'updated the username' do
        expect do
          put user_name_path(user), params: {
            user: {
              username: ''
            }
          }
        end.not_to change { user.reload.username }
        expect(response).to redirect_to(new_user_name_path)
      end
    end
  end
end
