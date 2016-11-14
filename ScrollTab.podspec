Pod::Spec.new do |s|
  s.name         = 'ScrollTab'

  s.version      = '2.0.0'

  s.summary      = 'Scrolling Tab'

  s.description  = 'A scroll tab alternative to UISegmentedControl.'

  s.homepage     = 'https://github.com/dkhamsing/ScrollTab'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { 'dkhamsing' => 'dkhamsing8@gmail.com' }

  s.social_media_url   = 'http://twitter.com/dkhamsing'

  s.platform     = :ios, '9.0'

  s.source       = { :git => 'https://github.com/dkhamsing/ScrollTab.git', :tag => s.version.to_s }

  s.source_files  = 'ScrollTab/*'

  s.requires_arc = true
end
