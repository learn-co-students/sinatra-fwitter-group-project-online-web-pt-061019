class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password


# downcase makes it lowercase. The strip makes sure there is no leading or trailing whitespace. The first gsub replaces spaces with hyphens. The second gsub removes all non-alpha non-dash non-underscore characters (note that this set is very close to \W but includes the dash as well, which is why it's spelled out here).
  def slug
    # binding.pry
    username = self.username
    slug = username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    # binding.pry
    @slug = slug
    format_slug_beginning
    results = self.where("username LIKE ?", @short_slug)
    results.detect do |result|
      result.slug === @slug
    end
  end

  def self.format_slug_beginning
    slug_beginning = @slug.split("-")[0]
    slug_beginning.prepend("%")
    slug_beginning << "%"
    @short_slug = slug_beginning
  end

end