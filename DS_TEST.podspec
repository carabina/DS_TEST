

Pod::Spec.new do |s|

  s.name          = "DS_TEST"
  s.version       = "1.0.0"
  s.license       = "MIT"
  s.summary       = "JSON to model for iOS."
  s.homepage      = "https://github.com/d2space/DS_TEST"
  s.author        = { "d2space" => "d2space@126.com" }
  s.source        = { :git => "https://github.com/d2space/DS_TEST.git", :tag => s.version }
  s.requires_arc  = true
  s.source_files  = 'DS_Tools/DS_Model.h'
  s.platform      = :ios, '7.0'
  s.framework     = 'Foundation'
  s.source_files     = "DS_Tools/**/*.{swift}"

end