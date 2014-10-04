class Post
  attr_reader :url, :title, :published_at

  def initialize(url, title, published_at)
    @url          = url
    @title        = title
    @published_at = published_at
  end
end