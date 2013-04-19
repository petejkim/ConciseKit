Pod::Spec.new do |s|
  s.name     = 'ConciseKit'
  s.version  = '0.1.3'
  s.license  = 'MIT'
  s.summary  = 'A set of Objective-C additions and macros that lets you write code more quickly.'
  s.homepage = 'http://github.com/petejkim/ConciseKit'
  s.author   = { 'Peter Jihoon Kim' => 'raingrove@gmail.com' }

  s.source   = { :git => 'http://github.com/goodtohear/ConciseKit.git' }

  s.source_files = 'src/**/*.{h,m}'

  s.preserve_paths = 'ConciseKitSpecs'

  s.frameworks = 'Foundation'
end

