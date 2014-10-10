class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    linkWithUrbanAirship
    loadBlogPostsList
    true
  end

  private
  def linkWithUrbanAirship
    config = UAConfig.defaultConfig

    UAirship.takeOff(config)
    UAPush.shared.userPushNotificationsEnabled = true
  end
  
  def loadBlogPostsList
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(blog_posts_view_controller)
    @window.makeKeyAndVisible
  end

  include Application
end
