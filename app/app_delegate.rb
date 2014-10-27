class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    integrateWithParse
    integrateParsePushNotifications(application)
    loadBlogPostsList
    true
  end

  def clearNotificationBadges
    UIApplication.sharedApplication.setApplicationIconBadgeNumber(0)
  end

  def integrateWithParse
    Parse.setApplicationId(env['PARSE_APP_ID'],
                           clientKey: env['PARSE_CLIENT_KEY'])
  end

  def integrateParsePushNotifications(application)
    if application.respond_to?(:isRegisteredForRemoteNotifications)
      settings = UIUserNotificationSettings.settingsForTypes(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge,
                                                             categories: nil)
      application.registerUserNotificationSettings(settings)
      application.registerForRemoteNotifications
    else
      application.registerForRemoteNotificationTypes(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
    end
  end

  def registerDeviceInParse(deviceToken)
    installation = PFInstallation.currentInstallation
    installation.setDeviceTokenFromData(deviceToken)
    installation.saveInBackground
  end

  def application(application, didReceiveRemoteNotification: userInfo)
    PFPush.handlePush(userInfo)
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    clearNotificationBadges
    registerDeviceInParse(deviceToken)
  end

  def application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    NSLog("Error while registering for Push Notifications: %@", error.localizedDescription)
  end

  def loadBlogPostsList
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(blog_posts_view_controller)
    @window.makeKeyAndVisible
  end

  include Application

  private
  def env
    NSBundle.mainBundle.infoDictionary
  end
end
