Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1091922357559241', '363e868abe8400060b9d670836ab0bd6'
end