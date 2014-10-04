class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    loadTheFirstScreen
    true
  end

  private
  def loadTheFirstScreen
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = blog_posts_view_controller
    @window.makeKeyAndVisible
  end

  include Application
end
