def client
  Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_KEY']
    config.consumer_secret     = ENV['TWITTER_SECRET']
    config.access_token        = session[:access_token]
    config.access_token_secret = session[:access_token_secret]
  end
end