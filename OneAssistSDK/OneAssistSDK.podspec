
Pod::Spec.new do |spec|

  spec.name         = "OneAssistSDK"
  spec.version      = "0.0.5"
  spec.summary      = "Framework for OneAssist memberhsip activation."

  spec.homepage     = "https://github.com/oneassist/sdk-fraud-detection-ios.git"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "Ankur Batham" => "ankur.batham@oneassist.in" }

  spec.platform     = :ios, "12.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/oneassist/sdk-fraud-detection-ios.git", :tag => "#{spec.version}" }

  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  spec.vendored_frameworks = "OneAssistSDK/OneAssistSDK.framework"

  spec.dependency 'Alamofire'
  spec.dependency 'DeviceKit'
  spec.dependency 'CocoaLumberjack/Swift'

end
