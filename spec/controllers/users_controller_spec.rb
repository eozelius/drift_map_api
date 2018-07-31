require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Create' do
    before { @request.headers["Content-Type"] = 'application/json' }

    it "rejects non JSON requests" do
      post :create
      expect(response.status).to eq(409)
    end

    it 'rejects invalid user data' do
      my_params = {
        data: {
          type: 'users',
          attributes: {
            email: nil,
            password: nil
          }          
        }
      }

      post :create, params: my_params
      expect(response.status).to eq(422)
    end

    it 'creates a new user' do
      user_count = User.count
      my_params = {
        data: {
          type: 'users',
          attributes: {
            email: 'asdf@asdf.com',
            password: 'asdfasdf'
          }          
        }
      }

      post :create, params: my_params
      expect(response.status).to eq(201)
      expect(User.count - 1).to eq(user_count)
    end

    it 'generates a new token for a newly created user' do
      my_params = {
        data: {
          type: 'users',
          attributes: {
            email: 'asdf@asdf.com',
            password: 'asdfasdf'
          }          
        }
      }

      post :create, params: my_params
      parsed = JSON.parse(response.body)
      new_user = User.find(parsed['data']['id'])

      expect(new_user.token).not_to eq(nil)
    end
  end

  describe 'get /user' do
    it 'rejects invalid tokens' do
      user = create(:user)
      request.headers['X-Api-Key'] = 'invalid_token'
      get :show, params: { id: user.id }
      expect(response.status).to eq(403)
    end

    it 'rejects invalid User Ids' do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end

    it 'returns User data' do
      user = create(:user)
      @request.headers['X-Api-Key'] = user.token
      get :show, params: { id: user.id }
      parsed = JSON.parse(response.body)
      expect(parsed['data']['attributes']['email']).to eq(user.email)
      expect(parsed['data']['relationships']).to include('driftmap')
    end
  end  

  describe 'ApplicationController' do
    it 'requires a request Mime type of JSON' do

      my_params = {
        data: {
          type: 'users',
          attributes: {
            email: 'asdf@asdf.com',
            password: 'asdfasdf'
          }          
        }
      }

      put :create, params: my_params
      expect(response.status).to eq(406)
    end
  end
end
