Pod::Spec.new do |s|

  s.name         = "PullToMakeFlight"
  s.version      = "3.0"
  s.summary      = "Custom animated pull-to-refresh that can be easily added to UIScrollView"

  s.homepage     = "http://yalantis.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = "Yalantis"
  s.social_media_url   = "https://twitter.com/yalantis"

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/Yalantis/PullToMakeFlight.git", :tag => s.version }
  s.source_files = "PullToMakeFlight/**/*.{h,swift}"
  s.resources    = ['PullToMakeFlight/Image.xcassets', 'PullToMakeFlight/**/*.{png,xib}']
  s.module_name  = "PullToMakeFlight"
  s.requires_arc = true
  s.framework   = 'CoreGraphics'

  s.dependency 'PullToRefresher', '~> 3.0'

end
