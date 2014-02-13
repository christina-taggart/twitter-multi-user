require 'twitter'

get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session[:access_token] = @access_token
  p "*"*200
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  @user = User.find_or_create_by_oauth_token(@access_token.token)
  @user.oauth_secret = @access_token.secret
  @user.username = @access_token.params[:screen_name]
  @user.save




  erb :index

end

post '/tweet' do
  @access_token = session[:access_token]

  @user = User.find_by_oauth_token(@access_token.token)
  $client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = @user.oauth_token
    config.access_token_secret = @user.oauth_secret
  end

  $client.update(params[:tweet_text])
  redirect '/'
end

