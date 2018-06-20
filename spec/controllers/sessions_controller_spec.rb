require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it "should route to create session" do
    skip
      assert_routing( { method: 'post', path: '/sessions' },
                      { controller: "sessions", action: "create" })
  end
  
  it "should route to delete session" do
    skip
      assert_routing({ method: 'delete', path: '/sessions/something'},
                       { controller: "sessions", action: "destroy", id: "something" })
  end

  it "Creating new session with valid data should create new session" do
    user = users('user_0')
    @request.headers["Content-Type"] = 'application/vnd.api+json'
    post :create, params: {
                    data: {
                      type: 'sessions',
                      attributes: {
                        full_name: user.full_name,
                        password: 'password' }}}
    assert_response 201
    jdata = JSON.parse response.body
    refute_equal user.token, jdata['data']['attributes']['token']
  end

  it "Should delete session" do
    user = users('user_0')
    delete :destroy, params: { id: user.token }
    assert_response 204
  end
end