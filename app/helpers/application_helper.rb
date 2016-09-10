module ApplicationHelper

  LOGIN_URL = '/login'

  MAIN_FOLDER_NAME = 'Meu Topbox'
  MAIN_FOLDER_PATH = '/mytopbox/'

  ACTION_NEW = 'new'
  ACTION_SHOW = 'show'



  def current_user_notifications
    Notification.where(user: get_current_user.id)
  end

  def qnt_notifications
    Notification.where(user: get_current_user.id).size
  end


end
