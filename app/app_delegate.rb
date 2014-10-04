class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    loadTheFirstScreen
    true
  end

  private
  def loadTheFirstScreen
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = BlogPostsListViewController.new
    @window.makeKeyAndVisible
  end
end
