Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = '/auth'
  end
  # The following is for facebook
  provider :facebook, '111011075721758', '528c55a44c4afa8bfeb82ba551cdc86d', {:scope =>'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
  # provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  # If you want to also configure for additional login services, they would be configured here.
end
