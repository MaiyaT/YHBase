
Pod::Spec.new do |s|
    s.name             = 'YHBase'
    s.version          = '1.5.3'
    s.summary          = 'GitHub MaiyaT - YHBase.'

    s.description      = <<-DESC
    YHBase url is https://github.com/MaiyaT/YHBase.git.
                       DESC

    s.homepage         = 'https://github.com/MaiyaT/YHBase'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '林宁宁' => '763465697@qq.com' }
    s.source           = { :git => 'https://github.com/MaiyaT/YHBase.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'
    s.platform     = :ios, '7.0'

    s.source_files = 'YHBase/Classes/**/*'

    s.resource_bundles = {
     'YHBase' => ['YHBase/Assets/*.png']
    }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'

    s.requires_arc = true


    s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -lstdc++', 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => "true"}

    s.libraries = 'sqlite3'

    s.dependency 'SCLAlertView-Objective-C'
    s.dependency 'Masonry'
    s.dependency 'pop'
    s.dependency 'FMDB'
    s.dependency 'SVProgressHUD'
    s.dependency 'AFNetworking'
    s.dependency 'IAPHelper'
    s.dependency 'AHKActionSheet'
    s.dependency 'SDWebImage'

end
