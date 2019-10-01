class Helpers
    def self.current_user(session_hash)
      @user = User.find(session_hash[:user_id]) # Returns the object associated with the user id
    end
  
    def self.is_logged_in?(session_hash)
      !!session_hash[:user_id] # Turns into a boolean
    end
  end