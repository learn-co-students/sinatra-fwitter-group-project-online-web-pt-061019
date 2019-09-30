class TweetsController < ApplicationController

    get '/tweets' do 
      # @tweets = Tweet.all
        if logged_in?
            @user = current_user
        erb :"/tweets/tweets"
        else 
            redirect "/login"
        end
    end

    get '/tweets/new' do 
        if logged_in?
            # binding.pry
            erb :"/tweets/new"
        else
            redirect '/login'
        end
    end

    post '/tweets' do
      # binding.pry
      if logged_in?     
          if params[:content].empty?
              redirect '/tweets/new'
          else
              # binding.pry
              @tweet = current_user.tweets.new(content: params[:content])
              if @tweet.save
                  redirect "/tweets/#{@tweet.id}"
              else
                  redirect '/tweets/new'
              end
          end
      else 
          redirect '/login'
      end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/show_tweet"
        else
            redirect '/login'
        end
    end


    get '/tweets/:id/edit' do
        if logged_in?
            # binding.pry
            @tweet = Tweet.find(params[:id])
                if @tweet && @tweet.user_id == current_user.id
                    erb :"/tweets/edit_tweet"
                else
                    redirect :'/tweets'
                end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        if logged_in?
            if params[:content].empty?
                redirect "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find_by_id(params[:id])
                if @tweet && @tweet.user == current_user
                    @tweet.update(content: params[:content])
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect "/tweets/#{@tweet.id}/edit"
                end 
                redirect to '/tweets'
            end
        else
            redirect '/login'
        end
    end
    
    #Remember: Put "" when there is a string interpolation ex. "/tweets/#{@tweet.id}/edit"


    delete '/tweets/:id' do
        # binding.pry
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user_id == current_user.id
            Tweet.delete(@tweet.id)
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

end
