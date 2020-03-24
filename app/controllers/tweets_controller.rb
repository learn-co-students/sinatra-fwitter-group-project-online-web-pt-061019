class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
    else
      redirect '/login'
    end
    erb :"/tweets/index"
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content].empty?
        redirect '/tweets/new'
      else
        @tweet = current_user.tweets.create(:content => params[:content])
      end
      redirect "tweets/#{@tweet.id}"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          erb :'tweets/edit'
        else
          redirect "/tweets"
        end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] == ""
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        if @tweet && @tweet.user == current_user
          @tweet.update(:content => params[:content])
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.destroy
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end


end
