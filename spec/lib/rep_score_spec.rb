require 'rails_helper'

describe RepScore do

  let(:user) {}

  describe "calculate_tweets_sentiment" do
    before do
      RepScore::POSITIVE_WORDS = %w(positive awesome)
      RepScore::NEGATIVE_WORDS = %w(negative)
    end

    let(:tweet1) { instance_double(Twitter::Tweet, :text => 'This is an awesome positive tweet') }
    let(:tweet2) { instance_double(Twitter::Tweet, :text => 'This is a negative tweet') }
    let(:tweet3) { instance_double(Twitter::Tweet, :text => 'This is a neutral tweet') }

    it 'returns 0 for neutral' do
      expect(RepScore.calculate_tweets_sentiment([tweet3])).to be == 0
    end

    it 'counts positive words' do
      expect(RepScore.calculate_tweets_sentiment([tweet1])).to be > 0
    end

    it 'counts negative words' do
      expect(RepScore.calculate_tweets_sentiment([tweet2, tweet3])).to be < 0
    end

    it 'no tweets' do
      expect(RepScore.calculate_tweets_sentiment([])).to be == 0
    end

  end
end