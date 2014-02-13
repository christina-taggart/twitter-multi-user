class TweetWorker
  include Sidekiq::Worker

  def Perfrom(tweet_id)
    tweet = Tweet.find(tweet_id)
    user = tweet.user

    end

end