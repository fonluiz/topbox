class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :show_navbar

  helper_method :get_current_user, :get_current_folder, :set_current_folder, :get_user_folders, :get_not_children_folders
  helper_method :redirect_to_mytopbox, :redirect_to_current_folder
  helper_method :find_mytopbox
  helper_method :get_current_document, :set_current_document, :all_users_except_current, :document_permissions

  @@current_folder #The Current folder should remain the same.
  @@current_docucument #The current/lastest document

  def get_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_current_folder
    return (@@current_folder ||= Folder.find_by(name: MAIN_FOLDER_NAME, user_id: get_current_user.id))
  end

  def set_current_folder(folder)
    @@current_folder = folder
  end

  def get_current_document
    @@current_docucument
  end

  def set_current_document(document)
    @@current_docucument = document
  end

  def require_user
    redirect_to LOGIN_URL unless logged_in?
  end

  def has_active_session?
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
    !get_current_user.nil?
  end

  def get_not_children_folders(children)
    @result = []
    folders = get_user_folders.where('id != ?', get_current_folder.id)
    get_children_folders(children.to_ary)
    return folders - @result
  end

  def document_permissions(document)
    Permission.where(document_id: document.id)
  end

  private
  def get_children_folders(children)
    if children.length != 0
      children.each do |c|
        child = []
        child.push(c)
        @result += child
        get_children_folders(c.children.to_ary)
      end
    end
  end

  protected
  def show_navbar
    @show_navbar = true
  end

  def redirect_to_mytopbox
    my_topbox = Folder.find_by(name: MAIN_FOLDER_NAME, user_id: get_current_user.id)
    my_topbox_id = my_topbox.id.to_s
    redirect_to MAIN_FOLDER_PATH + my_topbox_id
  end

  def redirect_to_current_folder
    redirect_to MAIN_FOLDER_PATH + get_current_folder.id.to_s
  end

  def find_mytopbox
    Folder.find_by(name: MAIN_FOLDER_NAME, user_id: get_current_user.id)
  end

  def get_user_folders
    Folder.where(user_id: get_current_user.id)
  end

  def all_users_except_current
    User.where('id != ?', get_current_user.id)
  end

end

