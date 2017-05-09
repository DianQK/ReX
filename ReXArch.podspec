Pod::Spec.new do |s|
  s.name             = "ReXArch"
  s.version          = "1.0.0"
  s.summary          = "ReX for iOS"
  s.description      = "ReX for iOS, write code like Redux."
  s.homepage         = "https://github.com/ReXSwift/ReX"
  s.license          = 'MIT'
  s.author           = { "DianQK" => "dianqk@icloud.com" }
  s.module_name      = 'ReX'
  s.source           = { :git => "https://github.com/ReXSwift/ReX.git", :tag => s.version.to_s }
  s.requires_arc          = true

  s.ios.deployment_target = '8.0'

  s.source_files = %w(ReX/*.swift)

end
