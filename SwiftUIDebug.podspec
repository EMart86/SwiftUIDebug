#
# Be sure to run `pod lib lint SwiftUIDebug.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'SwiftUIDebug'
s.version          = '1.0.6'
s.summary          = 'A lightweight on-screen debug UI written in Swift'

s.description      = <<-DESC
Sometimes it is easier and faster to visualize the log output within the same app. Of course a helpful debug tool doesn't costist of only a log output, there are some other helpful features planned. Stay up to date!'
DESC

s.homepage         = 'https://github.com/EMart86/SwiftUIDebug'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Martin Eberl' => 'eberl_ma@gmx.at' }
s.source           = { :git => 'https://github.com/EMart86/SwiftUIDebug.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '9.0'

s.source_files = 'SwiftUIDebug/Classes/**/*'

# s.resource_bundles = {
#   'SwiftUIDebug' => ['SwiftUIDebug/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
s.dependency 'EMTransformableNavigationController'
end
