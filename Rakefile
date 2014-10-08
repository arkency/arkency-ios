# -*- coding: utf-8 -*-
#
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'Arkency'
  app.version = '1.0'
  app.deployment_target = '7.0'
  app.icons = [1024, 180, 120, 76, 72, 60, 40].map { |n| "Icon_#{n}" }
  app.sdk_version = '8.0'
  app.identifier = 'com.arkency.app'
end
