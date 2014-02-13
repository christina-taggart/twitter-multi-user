class Tweet < ActiveRecord::Base
  belongs_to :user

  def client
    $client = Twitter::Client.new(
      oauth_token: user.oauth_token
      oauth_token_secret: user.oauth_token_secret
      )
  end
end
