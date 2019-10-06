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
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do 
    
    erb :'/tweets/tweets'
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
