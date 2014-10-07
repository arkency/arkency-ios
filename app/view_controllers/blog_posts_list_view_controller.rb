class BlogPostsListViewController < UIViewController
  POSTS_LIST_TAG = 1

  def start(use_case)
    @use_case = use_case
    @handler = BlogPostsListHandler.new(self, use_case)

    @use_case.on_posts_fetched do |blog_posts|
      handler.provide_blog_posts(blog_posts)
      blog_posts_table_view.reloadData
    end

    @use_case.on_post_request do |blog_post|
      reading_view_controller = BlogPostReadingViewController.new
      reading_view_controller.provide_blog_post(blog_post)

      self.navigationController.pushViewController(reading_view_controller, animated: true)
    end
  end

  def loadView
    self.view = NSBundle.mainBundle.loadNibNamed('BlogPostsList', owner: self, options: nil).first
    blog_posts_table_view.rowHeight = 200
  end

  def viewDidLoad
    super

    self.title = 'Blog Posts'
    provide_blog_posts_list_data_source(handler)
    provide_blog_posts_list_delegate(handler)
    use_case.user_entered_screen
  end

  private
  def provide_blog_posts_list_data_source(data_source)
    blog_posts_table_view.dataSource = data_source
  end

  def provide_blog_posts_list_delegate(delegate)
    blog_posts_table_view.delegate = delegate
  end

  def blog_posts_table_view
    view.subviews.find { |subview| subview.tag == POSTS_LIST_TAG }
  end

  private
  attr_reader :use_case, :handler
end
