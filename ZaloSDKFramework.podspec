#
# Be sure to run `pod spec lint ZaloSDKFramework.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'ZaloSDKFramework'
  s.version          = '2.2.0616'
  s.summary          = 'Zalo SDK Framework'

  s.description      = <<-DESC
Zalo software development kit for iOS
Document: http://developers.zalo.me/docs/sdk/ios-sdk-9
                       DESC

  s.homepage         = 'http://developers.zalo.me/docs/sdk/ios-sdk-9'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Liem Vo' => 'liemvouy@gmail.com' }
  s.source           = { :git => 'https://github.com/liemvu/ZaloSDKFramework.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZaloSDKFramework/Classes/**/*'

  s.frameworks = 'UIKit', 'MapKit', 'ZaloSDKCoreKit', 'ZaloSDK'
  s.vendored_frameworks  =  'ZaloSDKFramework/Frameworks/ZaloSDKCoreKit.framework', 'ZaloSDKFramework/Frameworks/ZaloSDK.framework'
  s.xcconfig = {
      'OTHER_LDFLAGS' => '-ObjC -framework ZaloSDK -framework ZaloSDKCoreKit',
      'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/ZaloSDKFramework/ZaloSDKFramework/Frameworks/**',
  }
  s.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '-ObjC'
  }
end
