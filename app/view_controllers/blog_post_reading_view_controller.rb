class BlogPostReadingViewController < UIViewController
  NAVIGATION_BAR_TAG = 0
  WEB_VIEW_TAG = 1

  def loadView
    self.view = NSBundle.mainBundle.loadNibNamed('BlogPostReading', owner: self, options: nil).first
  end

  def provide_blog_post(blog_post)
    @blog_post = blog_post
  end

  def viewDidLoad
    set_screen_title_to(blog_post.title)
    load_blog_post(blog_post)

    super
  end

  private
  attr_reader :blog_post

  def load_blog_post(blog_post)
    url = NSURL.URLWithString(blog_post.url)
    request = NSURLRequest.requestWithURL(url)
    webView.loadRequest(request)
  end

  def set_screen_title_to(title)
    navigationBarView.topItem.title = blog_post.title
  end

  def navigationBarView
    view.subviews.find { |subview| subview.tag == NAVIGATION_BAR_TAG }
  end

  def webView
    view.subviews.find { |subview| subview.tag == WEB_VIEW_TAG }
  end
end