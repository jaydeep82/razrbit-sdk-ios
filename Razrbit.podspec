Pod::Spec.new do |s|
  s.name     = 'Razrbit'
  s.version  = '0.0.2'
  s.license  = 'MIT'
  s.summary  = 'Singleton which allows access to the REST services offered by LUXSTACK.'
  s.description = 'Objective-C singleton object which allows access to the REST services offered by LUXSTACK from the iOS platform. All calls are invoked asynchronously and simply require a block completion callback which will be invoked automatically when the request finishes.'
  s.homepage = 'https://github.com/LUXSTACK/razrbit-sdk-ios/'
  s.authors  = {
    'Derek Lee' => 'dereklee@downtothis.com'
  }
  s.source   = { 
    :git => 'https://github.com/LUXSTACK/razrbit-sdk-ios.git',
    :tag => s.version.to_s,
    :submodules => false
  }
  s.requires_arc = true

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'

  s.public_header_files = 'Razrbit/*.h', 'Razrbit/Helpers/*.h', 'Razrbit/ServiceFacade/*.h'
  s.source_files = 'Razrbit/Razrbit*.{h,m}', 'Razrbit/Helpers/Razrbit*.{h,m}', 'Razrbit/ServiceFacade/Razrbit*.{h,m}'
  
  s.dependency 'PocketSocket', '0.6.3'
end