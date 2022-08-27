platform :ios, '13.0'

def pods_app_utilities
  pod 'Swinject', '2.8.1'
  pod 'RxSwift', '6.5.0'
  pod 'IQKeyboardManager', '6.5.10'
end


target 'Posterr' do
  pods_app_utilities
end

target 'PosterrTests' do
	post_install do |installer|
	    installer.pods_project.build_configurations.each do |config|
	      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
	    end
	end

  	pods_app_utilities
end
