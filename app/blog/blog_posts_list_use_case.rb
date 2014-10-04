class BlogPostsListUseCase
  def initialize(post_repository)
    @posts_fetched_callbacks = []
    @post_request_callbacks = []
    @post_repository = post_repository
  end

  def on_posts_fetched(&block)
    @posts_fetched_callbacks << block
  end

  def on_post_request(&block)
    @post_request_callbacks << block
  end

  def user_entered_screen
    post_repository.fetch_all_posts(method(:posts_fetched))
  end

  def user_requested_post(blog_post)
    post_request_callbacks.each { |callback| callback.call(blog_post) }
  end

  private
  def posts_fetched(blog_posts)
    posts_fetched_callbacks.each { |callback| callback.call(blog_posts) }
  end

  attr_reader :posts_fetched_callbacks, :post_repository
end