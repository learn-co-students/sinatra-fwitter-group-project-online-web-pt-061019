require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get '/signup' do 

    if logged_in?
        redirect '/tweets'
    else 
        erb :"/users/signup"
    end
end

post '/signup' do 
    # binding.pry
    user = User.new(params)
    if user.save && !params[:username].empty? && !params[:email].empty?
      session[:user_id] = user.id
      # params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect "/tweets"
    else
        # user = User.new(username: params[:username], email: params[:email], password: params[:password])
        # user.save
       
        redirect "/users/signup"
    end 
end

get '/login' do
  if logged_in?
    redirect '/tweets'
  else 
    erb :"/users/login"
  end
end

post '/login' do
  # binding.pry
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/tweets'
  else
    redirect '/signup'
  end
end

get '/logout' do
  # binding.pry
  if logged_in?    
    session.destroy
    redirect to '/login'
  else
    redirect '/'
  end
  
end



helpers do
    def logged_in?
      # !!session[:user_id]
      !!current_user
    end

    def current_user
      # User.find_by_id(session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

    end
  end
end
