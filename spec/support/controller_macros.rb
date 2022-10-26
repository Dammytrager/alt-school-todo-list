module ControllerMacros
  def sign_in_as(user)
    post login_path, params: { credentials: { email: user.email, password: '12345' } }
  end
end