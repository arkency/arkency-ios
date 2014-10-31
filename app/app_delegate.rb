class AppDelegate
  include Application

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    clearNotificationBadges
    integrateWithParse
    integrateParsePushNotifications
    loadBlogPostsList
    true
  end

  private
  def integrateWithParse
    Parse.setApplicationId(env['PARSE_APP_ID'],
                           clientKey: env['PARSE_CLIENT_KEY'])
  end

  def env
    NSBundle.mainBundle.infoDictionary
  end

  def integrateParsePushNotifications
    if app.respond_to?(:registerUserNotificationSettings)
      app.registerUserNotificationSettings UIUserNotificationSettings.settingsForTypes(notificationTypes, categories: nil)
      app.registerForRemoteNotifications
    else
      app.registerForRemoteNotificationTypes notificationTypes
    end
  end

  def notificationTypes
    UIUserNotificationTypeSound |
    UIUserNotificationTypeAlert |
    UIUserNotificationTypeBadge
  end

  def application(application, didReceiveRemoteNotification: userInfo)
    clearNotificationBadges
    PFPush.handlePush(userInfo)
  end

  def application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    NSLog("Error while registering for Push Notifications: %@", error.localizedDescription)
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    registerDeviceInParse(deviceToken)
  end

  def registerDeviceInParse(deviceToken)
    PFInstallation.currentInstallation.tap do |installation|
      installation.setDeviceTokenFromData(deviceToken)
      installation.saveInBackground
    end
  end

  def loadBlogPostsList
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(blog_posts_view_controller)
    @window.makeKeyAndVisible
  end

  def app
    UIApplication.sharedApplication
  end

  def clearNotificationBadges
    app.setApplicationIconBadgeNumber 1
    app.setApplicationIconBadgeNumber 0
    app.cancelAllLocalNotifications
  end
end
