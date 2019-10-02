class TweetsController < ApplicationController
 get '/tweets' do
  if Helpers.is_logged_in?(session)
    @tweets = Tweet.all
    erb :"/tweets/tweets"
  else
    redirect to '/login'
  end
 end

 post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    @user = Helpers.current_user(session)
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
 end

 get '/tweets/new' do
    if Helpers.is_logged_in?(session)
    erb :"/tweets/new"
    else
    redirect to '/login'
    end
 end

 get '/tweet/:id' do
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweet"
    else
    redirect to '/login'
    end
 end

get '/tweet/:id/edit' do
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/edit_tweet"
    end
end

patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:tweet][:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
    end
    @tweet.update(params[:tweet])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
end
end