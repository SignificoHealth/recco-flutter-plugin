#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint recco.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'recco'
  s.version          = '0.0.1'
  s.summary          = 'Recco Flutter plugin.'
  s.description      = <<-DESC
Brings all Significo Recco features to Flutter platform.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'Significo 2023 ©' }
  s.author           = { 'Significo' => 'recco@significo.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'ReccoUI', '~> 1.2.0'

  s.platform = :ios, '14.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.7'
end
