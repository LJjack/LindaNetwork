#
# Be sure to run `pod lib lint LindaNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LindaNetwork'
  s.version          = '0.1.0'
  s.summary          = 'Convenient framework for building network requests.'
  s.description      = 'LindaNetwork is a convenient framework for building network requests.'

  s.homepage         = 'https://github.com/LJjack/LindaNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LJjack' => '945980335@qq.com' }
  s.source           = { :git => 'https://github.com/LJjack/LindaNetwork.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.jianshu.com/u/5dfbfbe6f284'
  s.ios.deployment_target = '8.0'

  s.source_files = 'LindaNetwork/Classes/**/*'
  s.dependency 'YYModel'

end
