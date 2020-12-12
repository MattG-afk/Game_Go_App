class ApplicationController < ActionController::Base
    before_action :redirect_to_login
    helper_method :redirect_to_login, :current_user, :logged_in?, :authorized_to_edit?

  private


  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if session[:user_id].present?
        user = User.find_by(:id => session[:user_id])
    end
  end

  #def authorized_to_edit?(game)
    #byebug
    #game.id == current_user
  #end  

  def redirect_to_login
    redirect_to login_path if !logged_in?
  end

  def login(user)
    session[:user_id] = @user.id
    end

end
