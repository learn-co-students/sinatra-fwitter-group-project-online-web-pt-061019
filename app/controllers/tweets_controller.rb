class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      # @tweets = current_user.tweets
      @tweets = Tweet.all

      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do

    if logged_in?
      @user = current_user
      erb :'tweets/new'
    else
      redirect 'login'
    end
  end

  post '/tweets' do
    @user = current_user

    if params[:content] == ""
      redirect "/tweets/new"
    else
      @tweet = @user.tweets.build(params)
      if @tweet.save
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect 'login'
    end
  end

  # get '/tweets/:id/edit' do
  #   if logged_in?
  #     @user = current_user
  #     tweet_user = Tweet.find_by_id(params[:id]).user
  #     if post_user.id == @user.id
  #       @tweet = Tweet.find_by_id(params[:id])
  #       erb :'tweets/edit'
  #     else
  #       redirect "/tweets"
  #     end
  #   else
  #     redirect "/tweets"
  #   end
  # end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    params.delete("_method")
    if @tweet.update(params)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    tweet_user = Tweet.find_by_id(params[:id]).user
    if logged_in? && tweet_user.id == current_user.id
      Tweet.destroy(params[:id])
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
