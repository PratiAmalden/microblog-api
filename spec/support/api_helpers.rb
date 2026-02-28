require 'devise/jwt/test_helpers'
module ApiHelpers
  def auth_headers(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end
end