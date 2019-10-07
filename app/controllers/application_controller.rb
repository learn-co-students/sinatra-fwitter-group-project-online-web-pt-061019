require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :'index'   
  end

  get '/signup' do 
    if logged_in?
      redirect '/tweets'
    else
      erb :'/signup'
    end
  end

  post '/signup' do 
    @user = User.new(params)
    if @user.save 
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do 
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.aunthenticate(params[:password])
        session["user_id"] = user.id 
        redirect '/tweets'
    else
        erb :'/users/login'
    end
  end

  get '/logout' do 
    session.destroy
    redirect '/'
  end

  helpers do 
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user = User.find_by_id(session[:user_id])
    end
  end

end
