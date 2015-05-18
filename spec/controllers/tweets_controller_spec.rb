require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe "GET #index" do
    let(:params) { { :user_id => 'test' } }
    let(:client) { instance_double(Twitter::REST::Client)}
    let(:tweet)  { instance_double(Twitter::Tweet, :retweet_count => 5, :text => 'text', :created_at => DateTime.new, :media? => false) }

    before do
      controller.instance_variable_set(:@client, client)
      controller.stub(:initialize_twitter_client)
    end

    it "responds successfully with tweet" do
      allow(client).to receive(:search).and_return([tweet])
      get :index, params
      expect(response).to have_http_status(200)
      expect(response.body).to include(tweet.text)
    end

    it "can search by since date" do
      allow(client).to receive(:search).with('from:test since:2015-01-01').and_return([])
      get :index, params.merge(:since => '2015-01-01')
      expect(response).to have_http_status(200)
    end

    it "can search by until date" do
      allow(client).to receive(:search).with('from:test until:2015-01-01').and_return([])
      get :index, params.merge(:until => '2015-01-01')
      expect(response).to have_http_status(200)
    end

    it "can search by since and until date" do
      allow(client).to receive(:search).with('from:test since:2015-01-01 until:2015-01-01').and_return([])
      get :index, params.merge(:since => '2015-01-01', :until => '2015-01-01')
      expect(response).to have_http_status(200)
    end

    it "can search by with_picture" do
      allow(client).to receive(:search).with('from:test filter:images').and_return([])
      get :index, params.merge(:with_picture => 'on')
      expect(response).to have_http_status(200)
    end

    it "can search by min_retweets" do
      allow(client).to receive(:search).with('from:test').and_return([tweet])
      get :index, params.merge(:min_retweets => 10)
      expect(response).to have_http_status(200)
      expect(response.body).to eq "[]"
    end

    it "responds with 404 when not found" do
      allow(client).to receive(:search).and_raise(Twitter::Error)
      get :index, params
      expect(response).to have_http_status(404)
    end
  end
end
