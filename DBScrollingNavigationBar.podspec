Pod::Spec.new do |s|
s.name             = "DBScrollingNavigationBar"
s.version          = "1.0.0"
s.summary          = "Support for scrollable UINavigationBar and UITabBar that follows the scrolling of a UIScrollView."
s.license          = "MIT"
s.platform         = :ios, '7.0'

s.homepage         = "https://github.com/DevonBoyer/DBScrollingNavigationBar"
s.license          = 'MIT'
s.author           = { "Devon Boyer" => "devonboyer94@gmail.com" }
s.source           = { :git => "https://github.com/DevonBoyer/DBScrollingNavigationBar.git", :tag => s.version }

s.source_files = 'Pod/Classes/**/*'
s.resource_bundles = {
'DBScrollingNavigationBar' => ['Pod/Assets/*.png']
}

s.frameworks = 'UIKit', 'Foundation'
s.requires_arc = true

end
