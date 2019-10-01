require 'pry'
class UsersController < ApplicationController

    get '/signup' do
        if Helpers.is_logged_in?(session_hash)
          redirect '/tweets'
        end
        erb :'/users/create_user'
    end
  
    post '/signup' do
        #{"username"=>"skittles123", "email"=>"skittles@aol.com", "password"=>"rainbows"} 
      params.each do |field, input|
        if input.empty?
          redirect '/signup'
        end
      end
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end

    get '/login' do
     if Helpers.is_logged_in?(session)
        redirect to '/tweets'
     end
     erb :"/users/login"
    end

    post '/login' do
     @user = User.find(params[:id])
       erb :'/users/login'
     end

end
