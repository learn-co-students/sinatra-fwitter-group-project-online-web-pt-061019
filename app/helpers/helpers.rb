class Helpers
    def self.current_user
      @user = User.find(session[:user_id]) # Returns the object associated with the user id
    end
  
    def self.logged_in?
      !!session[:user_id] # Turns into a boolean
    end
  end