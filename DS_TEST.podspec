

Pod::Spec.new do |s|

  s.name          = "DS_TEST"
  s.version       = "1.0.0.5"
  s.license       = "MIT"
  s.summary       = "JSON to model for iOS."
  s.homepage      = "https://github.com/d2space/DS_TEST"
  s.author        = { "d2space" => "d2space@126.com" }
  s.platform     = :ios, "9.0"
  s.source        = { :git => "https://github.com/d2space/DS_TEST.git", :tag => "#{s.version}" }
  s.exclude_files = "Classes/Exclude"
  s.framework     = 'Foundation'
  s.vendored_frameworks = 'Tools/DS_ModelSDK.framework'

end