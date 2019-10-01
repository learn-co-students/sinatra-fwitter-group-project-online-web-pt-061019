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
        # binding.pry
        @user = User.create(params[:user])
        session[:user_id] = @user.id
        redirect to '/tweets'
      end

    get '/login' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        end
        erb :"/users/login"
        end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to '/tweets'
        else
          redirect to '/login'
        end
     end

end
