helpers do 

  def current_user
    @user = User.find_with_username(@access_token.params[:screen_name])
    session[:id] = @user.id
    session[:logged_in] = true
  end
  
end