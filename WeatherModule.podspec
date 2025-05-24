#
# Be sure to run `pod lib lint WeatherModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WeatherModule'
  s.version          = '0.1.5'
  s.summary          = 'A SwiftUI WeatherModule.'
  s.description      = 'A SwiftUI Weather View for iOS with basic weather information for a given location.'

  s.homepage         = 'https://github.com/stefan/WeatherModule'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'stefan' => 'stefan@27industries.co.za' }
  s.source           = { :git => 'https://github.com/stefan/WeatherModule.git', :tag => s.version.to_s }
  s.frameworks = 'SwiftUI', 'Foundation', 'UIKit'
  s.swift_version = '5.0'
  s.ios.deployment_target = '13.0'
  s.source_files = 'WeatherModule/Classes/**/*'
end
