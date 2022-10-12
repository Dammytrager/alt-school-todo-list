class AuthController < ApplicationController
  def sign_in
  end

  def sign_up
  end

  def login
  end

  # Handle the sign up
  def create_user
    user_params = params[:user].permit!
    user = User.create(user_params)

    redirect_to sign_in_path
  end
end