Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    :name => "google_oauth2",
    :scope => ['contacts','plus.login','plus.me','email','profile'],
    :prompt => "select_account",
    :access_type => 'offline'
  }
end
