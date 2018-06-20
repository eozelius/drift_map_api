require 'rails_helper'

RSpec.describe DriftmapsController, type: :controller do
  it "Should get valid list of posts" do
    skip
    get :index
    assert_response :success
    jdata = JSON.parse response.body
    assert_equal Post.count, jdata['data'].length
    assert_equal jdata['data'][0]['type'], 'posts'
  end
end