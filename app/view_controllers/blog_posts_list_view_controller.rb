class BlogPostsListViewController < UIViewController
  POSTS_LIST_TAG = 1

  def initialize(use_case)
    @use_case = use_case
    @handler = BlogPostsListHandler.new(use_case)

    @use_case.on_posts_fetched do |blog_posts|
      handler.provide_blog_posts(blog_posts)
      blog_posts_table_view.reloadData
    end
  end

  def loadView
    self.view = NSBundle.mainBundle.loadNibNamed('BlogPostsList', owner: self, options: nil).first
  end

  def viewDidLoad
    self.title = 'Blog Posts'
    provide_blog_posts_list_data_source(handler)
    use_case.user_entered_screen
  end

  private
  def provide_blog_posts_list_data_source(data_source)
    blog_posts_table_view.dataSource = data_source
  end

  def blog_posts_table_view
    view.subviews.find { |subview| subview.tag == POSTS_LIST_TAG }
  end

  private
  attr_reader :use_case, :handler
end
