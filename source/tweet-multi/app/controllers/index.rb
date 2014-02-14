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
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  # at this point in the code is where you'll need to create your user account and store the access token
  if not User.find_by_username(@access_token.params[:screen_name])
    @new_user = User.create(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  else
    @new_user = User.find_by_username(@access_token.params[:screen_name])
  end
  session[:access_token] = @access_token.token
  session[:access_token_secret] = @access_token.secret
  # session[:logged_in] = true
  erb :index
end

post '/tweet' do
  # p client
  # p params[:tweet]
  # client.update(params[:tweet])
end


# Now you'll need to implement that last step of the OAuth flow. Specifically, you'll need 
# to create the new user, 
#set her as "logged in", 
#store her access token and secret along with her user record, etc. 

#This should happen inside of the /auth route in your controllers/index.rb file:

# @access_token.params[:screen_name]

#<OAuth::AccessToken:0x007fbf7510f248 
# @token="1963774604-5YXOc4hgmIseCblUYOGx5FuelDogC5kyV11GfPK", 
# @secret="0n94K6sWsVugKPMNTE1qo5lT02Jgp5Xfny6eRP1r4fmEX", 
# @consumer=
#   #<OAuth::Consumer:0x007fbf71bff760 
#   @key="Ecu7MkMMMhEo8Y8D13I5A", 
#   @secret="lvszfbKvpA4EzGnmN4g0aCQPQuSOfgsLBKTUGO9qaI",
#   @options=
#     {:signature_method=>"HMAC-SHA1",
#     :request_token_path=>"/oauth/request_token",
#     :authorize_path=>"/oauth/authorize",
#     :access_token_path=>"/oauth/access_token",
#     :proxy=>nil, 
#     :scheme=>:header, 
#     :http_method=>:post, 
#     :oauth_version=>"1.0", 
#     :site=>"https://api.twitter.com"},
#   @http_method=:post,
#   @http=
#     #<Net::HTTP api.twitter.com:443 open=false>>,
#   @params=
#     {:oauth_token=>"1963774604-5YXOc4hgmIseCblUYOGx5FuelDogC5kyV11GfPK", "oauth_token"=>"1963774604-5YXOc4hgmIseCblUYOGx5FuelDogC5kyV11GfPK",
#       :oauth_token_secret=>"0n94K6sWsVugKPMNTE1qo5lT02Jgp5Xfny6eRP1r4fmEX", "oauth_token_secret"=>"0n94K6sWsVugKPMNTE1qo5lT02Jgp5Xfny6eRP1r4fmEX",
#       :user_id=>"1963774604", "user_id"=>"1963774604",
#       :screen_name=>"MatthewAHiggins", "screen_name"=>"MatthewAHiggins"}>






