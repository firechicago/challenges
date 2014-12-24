class SessionsController < ApplicationController
<<<<<<< HEAD
  attr_accessor :current_user
  def create
    @current_user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @current_user.id
    redirect_to '/questions'
=======

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
  end

  def destroy
    session[:user_id] = nil
<<<<<<< HEAD
    redirect_to '/questions'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
=======
    redirect_to root_url, :notice => "Signed out!"
>>>>>>> 6e871fb4e0efaf7d37fd2daf1218c52c13e64a73
  end
end
