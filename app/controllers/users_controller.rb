class UsersController < ApplicationController

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/signup' do
   if Helpers.is_logged_in?(session)
     redirect "/tweets"
   end

  erb :'/users/signup'

  end

  post '/signup' do
    params.each do |key, value|
      if value.empty?
        redirect "/signup"
      end
    end

    user = User.create(params)
    session[:user_id] = user.id
    redirect "/tweets"
  end

end
