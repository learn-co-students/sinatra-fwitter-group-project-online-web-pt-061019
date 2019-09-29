class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    # binding.pry
    self.username.downcase.gsub(" ", "-") 
  end

  def self.find_by_slug(slug)
    # binding.pry
    self.all.find{|user| user.slug == slug}
  end

end

