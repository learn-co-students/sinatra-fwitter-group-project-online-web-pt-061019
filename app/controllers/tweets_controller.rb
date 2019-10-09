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
        else
            redirect '/login'
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

    get '/tweets/:id' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet
                erb :'/tweets/show_tweet'
            else
                redirect '/tweets'
            end
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in? 
            user = Tweet.find_by_id(params[:id]).user 
            if user == current_user
                @tweet = Tweet.find_by_id(params[:id])
                erb :'/tweets/edit_tweet'
            else
                redirect '/tweets'
            end
        else
            redirect '/login' 
        end
    end 

    patch '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user == current_user
                if @tweet.update(content: params[:content])
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect "/tweets/#{@tweet.id}/edit"
                end
            end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user == current_user 
                Tweet.destroy(params[:id])
                redirect '/tweets'
            else 
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect '/login'
        end
    end
end
