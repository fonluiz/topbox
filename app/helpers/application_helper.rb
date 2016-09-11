module ApplicationHelper

  LOGIN_URL = '/login'

  MAIN_FOLDER_NAME = 'Meu Topbox'
  MAIN_FOLDER_PATH = '/mytopbox/'

  ACTION_NEW = 'new'
  ACTION_SHOW = 'show'


  def current_user_notifications
    Notification.where(user: get_current_user.id).order('id DESC').first(5)
  end

  def current_user_unread_notifications
    Notification.where(user: get_current_user.id).where(read: false)
>>>>>>> 244ad5f86e6bd708ff7a84cb39ed104ba32792b2
  end

  def qnt_notifications
    Notification.where(user: get_current_user.id).size
  end

  def qnt_unread_notifications
    notifications = Notification.where(user: get_current_user.id).where(read: false)
    size = notifications.size
    return size
  end


end
