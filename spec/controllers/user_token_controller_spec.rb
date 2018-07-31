require 'rails_helper'

RSpec.describe UserTokenController, type: :controller do
  before { @request.headers["Content-Type"] = 'application/json' }

  describe '#create' do

    it 'rejects invalid emails' do
      post :create, params: { email: nil, password: 'asdfasdf' }
      expect(response.status).to eq(406)
    end

    it 'rejects invalid passwords' do
      user = create(:user)
      old_token = user.token

      my_params = {
        data: {
          type: 'user_token',
          attributes: {
            email: user.email,
            password: nil
          }          
        }
      }

      post :create, params: my_params
      expect(response.status).to eq(403)
      expect(user.reload.token).to eq(old_token)
    end

    it 'creates a new token' do
      user = create(:user)
      old_token = user.token
      
      my_params = {
        data: {
          type: 'user_token',
          attributes: {
            email: user.email,
            password: user.password
          }          
        }
      }

      post :create, params: my_params
      parsed = JSON.parse(response.body)
      expect(user.reload.token).not_to eq(old_token)
      expect(response.status).to eq(201)
    end
  end

  describe '#destroy' do
    it 'rejects an invalid Token (404)' do
      post :destroy, params: { id: 0 }
      expect(response.status).to eq(404)
    end

    it 'deletes the token and regenerates another' do
      user = create(:user)
      old_token = user.token
      post :destroy, params: { id: user.token }
      expect(response.status).to eq(204)
      expect(user.reload.token).not_to eq(old_token)
    end
  end
end