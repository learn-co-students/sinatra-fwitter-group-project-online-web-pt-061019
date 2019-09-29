class UsersController < ApplicationController
    get '/signup' do
        if !logged_in?
            erb :"users/new"
        else
            redirect "/tweets"
        end
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save && !params[:username].empty? && !params[:email].empty?
            @user.save
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect "/tweets"
        else 
          erb :"/users/login"
        end
    end
      
    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end
end