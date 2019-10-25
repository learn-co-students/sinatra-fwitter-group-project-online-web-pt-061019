class UsersController < ApplicationController

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
    
    get '/users/login' do 
        if logged_in? 
          redirect :'/tweets'
        else
          erb :'/users/login'
        end
    end
    
    post '/users/login' do
        user = User.find_by(username: params[:username])
    
        if user && user.authenticate(params[:password])
            session["user_id"] = user.id 
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end
    
    get '/users/logout' do 
        if logged_in?
          session.destroy
          redirect '/users/login'
        else
          redirect '/index'
        end
    end

    get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end
end