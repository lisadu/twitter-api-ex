class RepScore

  CONFIG_PATH = Rails.root.join("config")
  POSITIVE_WORDS = File.readlines(CONFIG_PATH.join('positive-words.txt')).each { |l| l.chomp! }
  NEGATIVE_WORDS = File.readlines(CONFIG_PATH.join('negative-words.txt')).each { |l| l.chomp! }

  def self.calculate(user, tweets)

  end

  def self.calculate_tweets_sentiment(tweets)
    positive_words_count = 0
    negative_words_count = 0

    tweets.each do |tweet|
      words = tweet.text.split(/\W+/)
      words.each do |word|
        if word.downcase.in? POSITIVE_WORDS
          positive_words_count += 1
        elsif word.downcase.in? NEGATIVE_WORDS
          negative_words_count += 1
        end
      end
    end

    return (positive_words_count - negative_words_count).to_f / (tweets.count + 5)
  end
end