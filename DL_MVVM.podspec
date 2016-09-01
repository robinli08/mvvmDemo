Pod::Spec.new do |s|
  s.name             = "DL_MVVM"
  s.version          = "0.3.0"
  s.summary          = "MVVM For TableView&&Collection"
  s.description      = <<-DESC
                       Testing Private Podspec.
 
                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/robinli08"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"           #截图
  s.license          = 'MIT'              
  s.author           = { "robinli08" => "ielibo08@gmail.com" }                   
  s.source           = { :git => "https://github.com/robinli08/mvvmDemo.git", :tag => "0.3.1" }
 
  s.platform     = :ios, '7.0'
  s.requires_arc = true 
 
  s.source_files = 'DL_MVVM/Src/**/*.{h,m}'
  s.frameworks = 'UIKit','Foundation','CoreGraphics'

  s.dependency 'JSONModel', '~> 1.2.0'
  s.dependency 'ReactiveCocoa', '2.5'
end
