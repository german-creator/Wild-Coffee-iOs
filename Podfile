# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Wild App' do

  pod 'IQKeyboardManagerSwift', '~> 6.5'
  pod 'SwipeCellKit', '~> 2.7'
  
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  
  pod 'Nuke', '9.0.0-rc.1'
  pod 'AnyFormatKit'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
  end
  
  
end

