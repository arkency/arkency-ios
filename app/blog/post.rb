class Post
  attr_reader :url, :title, :published_at, :image_url

  def initialize(url, title, published_at, image_url = 'http://blog.arkency.com/assets/images/arkency-ios-placeholder.png')
    @url          = url
    @title        = title
    @published_at = published_at
    @image_url    = image_url
  end

  def set_found_image(image_url)
    @image_url = image_url
  end
end