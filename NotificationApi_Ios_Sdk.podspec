Pod::Spec.new do |s|
    s.name             = 'NotificationApi_Ios_Sdk'
    s.version          = '1.0.0'
    s.summary          = 'NotificationAPI for iOS'
    s.homepage         = 'https://github.com/notificationapi-com/notificationapi-ios-sdk'
    s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
    s.author           = { 'Devin' => 'devin@notificationapi.com' }
    s.source           = { :git => 'https://github.com/notificationapi-com/notificationapi-ios-sdk.git', :tag => s.version.to_s }
    s.ios.deployment_target = '13.0'
    s.swift_version = '5.8'
    s.source_files = 'Sources/NotificationApi_Ios_Sdk/**/*'
  end