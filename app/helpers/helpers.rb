class Helpers
    def self.current_user(session)
      @user = User.find(session[:user_id]) # Returns the object associated with the user id
    end
  
    def self.is_logged_in?(session)
      !!session[:user_id] # Turns into a boolean
    end
  end