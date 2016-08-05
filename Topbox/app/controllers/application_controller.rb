class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_folder, :set_current_folder
  @@current_folder #Its a class variable. The Current found should remain the same.
  before_filter :show_navbar



  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_folder
    return (@@current_folder ||= Folder.find_by(name: 'My TopBox', owner_id: current_user.id))
  end

  def set_current_folder(folder)
    @@current_folder = folder
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def save_login_state
    if session[:user_id]
      redirect_to '/folders'
      return false
    else
      return true
    end
  end

  def log_out
    session[:user_id] = nil
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  protected
  def show_navbar
    @show_navbar = true
  end

end

