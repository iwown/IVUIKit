Pod::Spec.new do |s|

s.name         = 'IVUIKit'

s.version      = "1.0.3"

s.summary      = 'UI tools used in iwown iOS developer team'

s.license      = 'MIT'

s.author       = { "xuezou" => "377949550@qq.com" }

s.homepage     = 'https://github.com/xuezou/IVUIKit'

s.source       = { :git => "https://github.com/xuezou/IVUIKit.git", :tag => s.version}

s.source_files = "Products/", "Products/**/*.{h,m}"

s.platform     = :ios, "10.0"

#s.frameworks = 'Foundation'

s.resource     = 'Products/IVUIKit.bundle'

s.requires_arc = true

s.dependency 'lottie-ios', '~> 2.5.0'
s.dependency 'Masonry'

end
