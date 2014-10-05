class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    loadBlogPostsList
    true
  end

  private
  def loadBlogPostsList
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(blog_posts_view_controller)
    @window.makeKeyAndVisible
  end

  include Application
end
