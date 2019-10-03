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
    if Helpers.is_logged_in?(session)
        if params[:content].empty?
            redirect to '/tweets/new'
        end
    @tweet = Tweet.create(params)
    @tweet.user_id = Helpers.current_user(session).id
    @tweet.save
    redirect to "/tweets"
    else
        redirect to '/login'
    end
 end

 get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find_by_id(params[:id])
    erb :"/tweets/show_tweet"
    else
    redirect to '/login'
    end
 end

get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
        erb :"/tweets/edit_tweet"
        end
    else
        redirect to '/login'
    end
end

patch '/tweets/:id' do
    
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find_by_id(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
            if params[:content].empty?
            redirect "/tweets/#{@tweet.id}/edit"
            end
        @tweet.update(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
        end
    else
        redirect to 'login'
    end
end

delete '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
            @tweet.delete
            redirect to '/tweets'
        end
    else
        redirect to '/login'
    end
end

end