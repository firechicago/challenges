class SessionsController < ApplicationController
  attr_accessor :current_user
  def create
    @current_user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @current_user.id
    redirect_to '/questions'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/questions'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
