class UsersController < ApplicationController

post '/users' do 
    @user = User.new(params)
    erb :'/tweets/tweets'
end

end