class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_folder, :set_current_folder, :set_carl, :carl
  @@current_folder #Its a class variable. The Current found should remain the same.
  before_filter :show_navbar


  #Set the current user if there is a session.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #Finds the current folder using the current user id and return it.
  def current_folder
    return (@@current_folder ||= Folder.find_by(name: 'My TopBox', user_id: current_user.id))
  end

  #Receive a folder as argument and set the current folder to it.
  def set_current_folder(folder)
    @@current_folder = folder
  end

  #If there isn't a current user no matter what page is acessed the user is redirected to the login page.
  def require_user
    redirect_to '/login' unless current_user
  end

  #
  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'folders', :action => 'new')
      return false
    else
      return true
    end
  end

  #Log the user out.
  def log_out
    session[:user_id] = nil
  end

  #Receive an user as agurment and log him in.
  def log_in(user)
    session[:user_id] = user.id
  end

  #See if has an user logged in.
  def logged_in?
    !current_user.nil?
  end

  #Show the nav bar.
  protected
  def show_navbar
    @show_navbar = true
  end

end

