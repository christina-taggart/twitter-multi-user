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
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  username = @access_token.params[:screen_name]
  token = @access_token.token
  secret = @access_token.secret

  @new_user = User.create(username: username, oauth_token: token, oauth_secret: secret)
  # at this point in the code is where you'll need to create your user account and store the access token

  redirect "/#{@new_user.id}"
  erb :index
end

get '/:user_id' do
  @user = User.find(params[:user_id])
  erb :user
end

post '/:user_id' do
  @user = User.find(params[:user_id])
  client = configure_client(@user.oauth_token, @user.oauth_secret)
  client.update(params[:tweet])
  erb :user
end
