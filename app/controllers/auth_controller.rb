class AuthController < ApplicationController
  before_action :requires_guest, except: [:logout]
  before_action :requires_sign_in, only: [:logout]

  def sign_in
  end

  def sign_up
  end

  def login
    credentials = params[:credentials]
    user = User.find_by(email: credentials[:email])
    if user.present?
      if user.authenticate(credentials[:password])
        session[:user] = user.id
        redirect_to todos_path
      else
        flash[:error] = 'Password is not correct'
        render 'auth/sign_in'
      end
    else
      flash[:error] = 'User with email does not exist'
      render 'auth/sign_in'
    end
  end

  # Handle the sign up
  def create_user
    user_params = params[:user].permit!

    if User.find_by(email: user_params[:email]).present?
      # show user an error that the email already exist
      flash[:error] = 'User with email already exists'
      render 'auth/sign_up'
    else
      user = User.create(user_params)
      if user.errors&.full_messages.present?
        flash[:error] = user.errors&.full_messages[0]
        return render 'auth/sign_up'
      end

      redirect_to sign_in_path
    end
  end

  def logout
    session[:user] = nil
    redirect_to login_path
  end
end