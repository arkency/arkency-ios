class Post
  attr_reader :url, :title, :published_at, :image_url

  def initialize(url, title, published_at, image_url = 'http://i61.tinypic.com/2vchvn9.png')
    @url          = url
    @title        = title
    @published_at = published_at
    @image_url    = image_url
  end

  def set_found_image(image_url)
    @image_url = image_url
  end
end