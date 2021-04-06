CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        
    aws_access_key_id:     Rails.application.credentials[:aws][:access_key_id],                        
    aws_secret_access_key: Rails.application.credentials[:aws][:secret_access_key],                        
    region:                'ap-northeast-1',                  
  }
  config.fog_directory  = 'shirostagram'                                      
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file
end
