class BlogPostsListViewController < UIViewController
  SEARCH_BAR_TAG = 0
  POSTS_LIST_TAG = 1

  def loadView
    self.view = NSBundle.mainBundle.loadNibNamed('BlogPostsList', owner: self, options: nil).first
  end

  def viewDidLoad
    self.title = 'Blog Posts'

    configureBlogPostsList
  end

  private
  def configureBlogPostsList
    blogPostsTableView.dataSource = BlogPostsListInMemoryDataSource.new
  end

  def blogPostsTableView
    view.subviews.find { |subview| subview.tag == POSTS_LIST_TAG }
  end
end
