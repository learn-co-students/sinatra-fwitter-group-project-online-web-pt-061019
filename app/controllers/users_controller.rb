require 'pry'
class UsersController < ApplicationController

    get '/signup' do
      # binding.pry
        if !!session[:user_id]
          redirect to '/tweets'
        else
        erb :"/users/create_user"
        end
      end
  
    post '/signup' do
        #{"username"=>"skittles123", "email"=>"skittles@aol.com", "password"=>"rainbows"}
        params.each do |label, input|
          if input.empty?
            redirect to '/signup'
          end
        end
        @user = User.create(params)
        session[:user_id] = @user.id
        # binding.pry
        redirect to '/tweets'
      end

    get '/login' do
      if !!session[:user_id]
        redirect to '/tweets'
      else
      erb :"/users/login"
      end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/tweets'
        else
          redirect to '/login'
        end
     end

     get '/logout' do
      if !!session[:user_id]
      erb :"/user/logout"
      else
        redirect to '/login'
      end
    end


      post '/logout' do
        session.clear
      redirect to '/'
     end


end
