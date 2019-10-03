class TweetsController < ApplicationController
 get '/tweets' do
  if Helpers.is_logged_in?(session)
    @tweets = Tweet.all
    erb :"/tweets/tweets"
  else
    redirect to '/login'
  end
 end

 get '/tweets/new' do
    if Helpers.is_logged_in?(session)
    erb :"/tweets/new"
    else
    redirect to '/login'
    end
 end

 post '/tweets' do
    if params[:content].empty?
        redirect to '/tweets/new'
    else
    @tweet = Tweet.create(params)
    @tweet.user_id = Helpers.current_user(session)
    redirect to "/tweets"
    end
 end

 get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find_by(params[:id])
    erb :"/tweets/show_tweet"
    else
    redirect to '/login'
    end
 end

get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
        erb :"/tweets/edit_tweet"
        end
    else
        redirect to '/login'
    end
end

patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
    else
    @tweet.update(params[:content])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
    end
end

delete '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
            @tweet.delete
            redirect to '/tweets'
        end
    else
        redirect to '/login'
    end
end

end