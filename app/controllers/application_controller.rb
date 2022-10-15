class ApplicationController < ActionController::Base
  before_action :verify_auth,

  def verify_auth
    @user = session[:user] ? User.find(session[:user]) : nil
    @user_signed_in = @user.present?
  end

  def requires_sign_in
    if !@user_signed_in
      flash[:error] = 'You need to sign in'
      redirect_to sign_in_path
    end
  end

  def requires_guest
    if @user_signed_in
      redirect_to todos_path
    end
  end
end
