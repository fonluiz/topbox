class SessionsController < ApplicationController
  include SessionsHelper, ApplicationHelper
  before_action :has_active_session?, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new, :create]

  def new

  end

  def create
    @user = find_user(params[:session][:find_user])

    if @user && @user.authenticate(params[:session][:login_password])
      log_in @user
      redirect_to url_for(:controller => 'folders', :action => ACTION_INDEX)
    else
      if empty_field?
        flash.now[:danger] = t(:empty_field)
      else
        flash.now[:danger] = t(:authentication_error)
      end
      render :new
    end
  end

  def empty_field?
    if ( (params[:session][:find_user].empty?)    or
        (params[:session][:login_password].empty?)  )
      #retorna verdadeiro se algum campo estiver vazio
      return true
    else
      return false
    end
  end

  def destroy
    respond_to do |format|
        log_out
        format.html { redirect_to :action => ACTION_NEW, :notice => t(:logout)}
    end
  end

  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:educator_locale] = l
    redirect_to request.referer || root_url
  end

  # Returns the user in the database that corresponds to the email or username passed as arguments.
  private
  def find_user(email_or_username="")
    if email_or_username != ""
      user ||= User.find_by_email(email_or_username)
      user ||= User.find_by_username(email_or_username)
    end
    return user
  end
end
