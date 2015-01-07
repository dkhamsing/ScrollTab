Pod::Spec.new do |s| 
  s.name         = 'DKScrollingTabController'

  s.version      = '1.1.2'

  s.summary      = 'Scrolling Tab iOS Control.'

  s.description  = 'A scrolling tab controller alternative to UISegmentedControl.'

  s.homepage     = 'https://github.com/dkhamsing/DKScrollingTabController'

  s.screenshots  = 'https://github.com/dkhamsing/DKScrollingTabController/raw/master/Assets/demo.gif'
 
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { 'dkhamsing' => 'dkhamsing8@gmail.com' }
  
  s.social_media_url   = 'http://twitter.com/dkhamsing'
   
  s.platform     = :ios, '7.0'
 
  s.source       = { :git => 'https://github.com/dkhamsing/DKScrollingTabController.git', :tag => '1.1.2' }

  s.source_files  = 'DKScrollingTabController/*'
  
  s.requires_arc = true
end
