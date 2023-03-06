# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'POST create' do
    context 'user not logged in' do
      it 'it successful ' do
        post tweets_path, params: {
          tweet: {
            body: 'New tweet body'
          }
        }
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'user logged in' do
      it 'redirect to dashboard_path' do
        user = create(:user)
        sign_in user
        expect do
          post tweets_path, params: {
            tweet: {
              body: 'New tweet body'
            }
          }
        end.to change { Tweet.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
