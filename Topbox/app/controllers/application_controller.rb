class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :show_navbar

  helper_method :current_user, :current_folder, :set_current_folder
  helper_method :redirect_to_mytopbox, :find_mytopbox, :user_folders

  @@current_folder #Its a class variable. The Current found should remain the same.

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_folder
    return (@@current_folder ||= Folder.find_by(name: 'My TopBox', user_id: current_user.id))
  end

  def set_current_folder(folder)
    @@current_folder = folder
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def save_login_state
    if session[:user_id]
      redirect_to_mytopbox
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

  def redirect_to_mytopbox
    my_topbox_id = Folder.find_by(name: 'My TopBox', user_id: current_user.id).id.to_s
    redirect_to '/mytopbox/' + my_topbox_id
  end

  def find_mytopbox
    Folder.find_by(name: 'My topbox', user_id: current_user.id)
  end

  def user_folders
    folders = Folder.where(user_id: current_user.id).where('id != ?', current_folder.id)
  end

end

