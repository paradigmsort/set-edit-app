include Warden::Test::Helpers

module DeviseRequestHelpers
  def sign_in(user)
    login_as user, scope: :user
  end
end

RSpec.configure do |config|
  config.include DeviseRequestHelpers, type: :request
end