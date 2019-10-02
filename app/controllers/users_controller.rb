require 'pry'
class UsersController < ApplicationController

    get '/signup' do
      # binding.pry
      if Helpers.is_logged_in?(session)
          redirect to '/tweets'
      end
        erb :"/users/create_user"
        end
    
  
    post '/signup' do
        #{"username"=>"skittles123", "email"=>"skittles@aol.com", "password"=>"rainbows"}
        params.each do |label, input|
          if input.empty?
            redirect to '/signup'
          end
        end
        user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
        session[:user_id] = user.id
        # binding.pry
        redirect to '/tweets'
      end

    get '/login' do
      if Helpers.is_logged_in?(session)
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
      if Helpers.is_logged_in?(session)
        session.clear
        redirect to '/login'
      else
        redirect to '/'
      end
    end

end
