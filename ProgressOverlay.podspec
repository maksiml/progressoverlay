#
# Be sure to run `pod lib lint ProgressOverlay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ProgressOverlay'
  s.version          = '1.0.0'
  s.summary          = 'NSView extension that presents progress view on top of the NSView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Presents a transparent progress view on top of the NSView. The progress view will disable any input to underlaying 
controls to prevent user interaction while action is in progress. The control used by the progress view is standard NSProgress. 
                       DESC

  s.homepage         = 'http://progressoverlay.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'maksiml@ceemax.com' => 'maksiml@ceemax.com' }
  s.source           = { :git => 'https://github.com/maksiml/progressoverlay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ProgressOverlay'

  s.platform = :osx
  s.osx.deployment_target = "10.10"
  s.swift_version = "4.2"

  s.source_files = 'ProgressOverlay/Classes/**/*'

  # s.resource_bundles = {
  #   'ProgressOverlay' => ['ProgressOverlay/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'Cocoa'
  # s.dependency 'AFNetworking', '~> 2.3'
end
