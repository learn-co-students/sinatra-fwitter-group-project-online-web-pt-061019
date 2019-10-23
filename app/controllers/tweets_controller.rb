class TweetsController < ApplicationController

    get '/tweets' do 
        if Helpers.is_loged_in?(session)
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect to '/user/login'
        end
    end

    get '/tweets/new' do 
        user = Helpers.current_user(session)
        if user.nil?
            redirect to '/login'
        else
            erb :'tweets/create_tweet'
        end
    end

    post '/tweets' do
        user = Helpers.current_user(session)
        if user.nil?
            redirect to '/login'
        elsif params[:tweet][:content].empty?
            redirect to 'tweets/new'
        else
            user.tweet.build({content: params[:tweet][:content]})
            user.save
        end
            redirect to '/tweets'
    end

    get '/tweets/:id' do
        redirect to '/login' unless Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])

        erb :'/tweets/show_tweet'
    end

    get '/tweete/:id/edit' do
        redirect to '/login' unless Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        if @tweet.user == Helpers.current_user(session)
            erb :'/tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do 
        @tweet = Tweet.fing(params[:id])
        
        if params[:tweet][:content].empty?
            redirect to "/tweets/#{@tweet.id}/edit"
        end
        @tweet.update(params[:tweet])
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id/delete' do 
        tweets = Tweet.find_by_id(params[:id]).user
        if tweets.id == current_user.id
            Tweet.destory(params[:id])
            redirect :'/tweets'
        else
            redirect :'/tweets'

        end
    end
end

