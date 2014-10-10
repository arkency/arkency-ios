# -*- coding: utf-8 -*-
#
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'dotenv'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Dotenv.load('.env')

Motion::Project::App.setup do |app|
  app.name = 'Arkency'
  app.version = '1.0'
  app.deployment_target = '7.0'
  app.icons = [1024, 180, 120, 76, 72, 60, 40].map { |n| "Icon_#{n}" }
  app.sdk_version = '8.0'
  app.identifier = 'com.arkency.app'

  app.vendor_project('vendor/DistanceOfTimeInWords', :static, :cflags => '-fobjc-arc')
  app.vendor_project('vendor/Parse.framework', :static, products: ['Parse'], headers_dir: 'Headers')
  app.vendor_project('vendor/Bolts.framework', :static, products: ['Bolts'], headers_dir: 'Headers')

  app.frameworks += [
    'Social',
    'FacebookSDK',
    'StoreKit',
    'AudioToolbox',
    'CFNetwork',
    'SystemConfiguration',
    'MobileCoreServices',
    'Security',
    'QuartzCore'
  ]

  app.entitlements['aps-environment'] = ENV['APNS_ENVIRONMENT']

  app.pods do
    pod 'AFNetworking'
  end

  app.info_plist['PARSE_CLIENT_KEY'] = ENV['PARSE_CLIENT_KEY']
  app.info_plist['PARSE_APP_ID']     = ENV['PARSE_APP_ID']

  app.development do
    app.entitlements['get-task-allow'] = true
    app.provisioning_profile = ENV['APPLE_PROVISIONING_PROFILE_PATH']
    app.codesign_certificate = "iPhone Developer: #{ENV['APPLE_DEVELOPER_NAME']}"

    app.testflight do
      app.testflight.api_token          = ENV['TESTFLIGHT_API_TOKEN']
      app.testflight.team_token         = ENV['TESTFLIGHT_TEAM_TOKEN']
      app.testflight.app_token          = ENV['TESTFLIGHT_APP_TOKEN']
      app.testflight.distribution_lists = ['Arkency']
      app.testflight.notify             = true
      app.testflight.identify_testers   = true
    end
  end

  app.release do
    app.provisioning_profile = ENV['APPLE_PROVISIONING_PROFILE_PATH']
    app.codesign_certificate = "iPhone Distribution: #{ENV['APPLE_COMPANY_NAME']}"
  end
end
