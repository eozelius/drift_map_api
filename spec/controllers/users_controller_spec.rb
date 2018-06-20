require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'INDEX' do
    it 'responds with JSON"' do
      get :index
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/vnd.api+json')
      # jdata = JSON.parse response.body
    end
  end

  context 'CREATE' do
    it 'rejects empty requests' do
      post :create
      expect(response.status).to eq(406)
    end

    it "rejects requests without X-Api-Key" do
      @request.headers["Content-Type"] = 'application/vnd.api+json'
      post :create, params: {}
      expect(response.status).to eq(403)
    end

    it 'rejects incorrect X-Api-Keys' do
      @request.headers["Content-Type"] = 'application/vnd.api+json'
      @request.headers["X-Api-Key"] = '0000'
      post :create, params: {}
      assert_response 403
    end

    it 'rejects invalid user data' do
      skip
      @request.headers["Content-Type"] = 'application/vnd.api+json'
      @request.headers["X-Api-Key"] = user.token
      post :create, params: { data: { type: 'posts' }}
      assert_response 409
    end

    it 'creates a new user' do
    end
  end

  
end
