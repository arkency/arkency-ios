module Application
  def blog_posts_view_controller
    @blog_posts_list_view_controller ||= BlogPostsListViewController.new(blog_posts_use_case)
  end

  def blog_posts_use_case
    @blog_posts_use_case ||= BlogPostsListUseCase.new(post_repository)
  end

  def post_repository
    @post_repository ||= PostRepository.new(blog_adapter)
  end

  def blog_adapter
    @blog_adapter ||= BlogAdapter.new
  end
end