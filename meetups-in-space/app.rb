require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/reloader'
require 'omniauth-github'
require 'pry'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def current_user
  user_id = session[:user_id]
  @current_user ||= User.find(user_id) if user_id.present?
end

def set_current_user(user)
  # binding.pry
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @meetups = Meetup.all.sort_by { |meetup| meetup.name }
  erb :index
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']
  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"
  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."
  redirect '/'
end

get '/create' do
  authenticate!
  erb :create
end

get '/meetups/:id' do
  @meetup = Meetup.find(params['id'].to_i)
  erb :show
end

post '/create' do
  authenticate!
  new_meetup = Meetup.create(name: params['Name'], location: params['Location'], description: params['Description'])
  Membership.create(meetup_id: new_meetup.id, user_id: current_user.id)
  id = new_meetup.id.to_s
  flash[:notice] = "Meetup \"#{new_meetup.name}\" created!"
  redirect '/meetups/' + id
end

get '/join/:meetup_id' do
  authenticate!
  Membership.create(meetup_id: params['meetup_id'], user_id: current_user.id)
  flash[:notice] = "You joined #{Meetup.find(params['meetup_id']).name}"
  redirect '/meetups/' + params['meetup_id']
end

get '/leave/:meetup_id' do
  authenticate!
  membership = Membership.where(meetup_id: params['meetup_id'], user_id: current_user.id)
  Membership.destroy(membership[0].id)
  flash[:notice] = "You left #{Meetup.find(params['meetup_id']).name}"
  redirect '/meetups/' + params['meetup_id']
end

post '/comment/:meetup_id' do
  authenticate!
  meetup = Meetup.find(params['meetup_id'].to_i)
  if meetup.users.include?(current_user)
    Comment.create(user_id: current_user.id, meetup_id: meetup.id, content: params['content'])
    flash[:notice] = 'Comment Posted'
    redirect '/meetups/' + params['meetup_id']
  else
    flash[:notice] = "You must be a member of this meetup to comment."
    redirect '/meetups/' + params['meetup_id']
  end
end
