class BlogPostsListHandler
  def initialize(view_controller, use_case, blog_posts = [])
    @view_controller = view_controller
    @blog_posts      = blog_posts
    @use_case        = use_case
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    render_blog_post_entry(blog_posts[indexPath.row])
  end

  def tableView(tableView, numberOfRowsInSection: section)
    blog_posts.count
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    use_case.user_requested_post(blog_posts[indexPath.row])
  end

  def provide_blog_posts(blog_posts)
    @blog_posts = blog_posts
  end

  private
  def render_blog_post_entry(blog_post)
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: blog_post.url)
    cell.textLabel.text = blog_post.title
    cell
  end

  private
  attr_reader :blog_posts, :use_case, :view_controller
end