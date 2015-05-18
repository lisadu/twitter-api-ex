require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe "GET #index" do
    let(:params) { { :user_id => 'test' } }
    let(:client) { instance_double(Twitter::REST::Client)}

    before do
      controller.instance_variable_set(:@client, client)
      controller.stub(:initialize_twitter_client)
    end

    it "responds successfully" do
      allow(client).to receive(:search).and_return([])
      get :index, params
      expect(response).to have_http_status(200)
    end

    it "responds with 404 when not found" do
      allow(client).to receive(:search).and_raise(Twitter::Error)
      get :index, params
      expect(response).to have_http_status(404)
    end
  end
end
