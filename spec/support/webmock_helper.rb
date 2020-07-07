# frozen_string_literal: true

module WebmockHelper
  WebMock.disable_net_connect!(
    allow_localhost: true,
    allow: "chromedriver.storage.googleapis.com"
  )
end
