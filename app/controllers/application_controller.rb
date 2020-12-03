class ApplicationController < ActionController::Base
    before_action :redirect_to_login
    helper_method :redirect_to_login, :current_user, :logged_in?, :authorized_to_edit?

  private


  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def authorized_to_edit?(game)
    game.user == current_user
  end  

  def redirect_to_login
    redirect_to login_path if !logged_in?
  end
end
