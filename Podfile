# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'
use_frameworks!
target 'PruebaDomicilios' do

  pod 'SwiftyJSON', :git => 'https://github.com/acegreen/SwiftyJSON.git', :branch => 'swift3'
  pod 'Alamofire', '~> 4.0'
  pod 'SwiftSpinner'
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
