class User < ActiveRecord::Base
  has_many :tweets
  validates :username, uniqueness: true

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end
end
