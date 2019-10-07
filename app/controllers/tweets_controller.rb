class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = current_user
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            @user = current_user
            erb :'/tweets/new'
        end
    end 

    post '/tweets' do 
        @tweet = current_user.tweets.new(content: params[:content])
        if @tweet.content != "" && @tweet.save
            redirect '/tweets'
        else
            redirect '/tweets/new'
        end
        erb :'/tweets/tweets'
    end
end
