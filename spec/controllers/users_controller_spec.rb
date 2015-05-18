require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    let(:params) { { :id => 'test' } }
    let(:client) { instance_double(Twitter::REST::Client) }

    before do
      controller.instance_variable_set(:@client, client)
      controller.stub(:initialize_twitter_client)
    end

    it "responds successfully with tweet" do
      allow(client).to receive(:user).and_return(instance_double(Twitter::User, :followers_count => 1, :friends_count => 1, :name => 'test', :screen_name => 'test', :profile_image_url => ''))
      get :show, params
      expect(response).to have_http_status(200)
    end

    it "responds with 404 when not found" do
      allow(client).to receive(:user).and_raise(Twitter::Error)
      get :show, params
      expect(response).to have_http_status(404)
    end
  end
end
