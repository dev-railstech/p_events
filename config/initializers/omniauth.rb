Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '176918102515592', 'ade49f45643a1329c6c1589a2310307f'
  provider :twitter, 'yRxUO6ZCdjwn9yG2TCmxKw', '0BD0dKRP2STbtOUH9RCxj3LSSW6DklyIKCwArG4'
end