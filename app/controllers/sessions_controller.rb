class SessionsController < ApplicationController
  include SessionsHelper, ApplicationHelper
  before_action :has_active_session?, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new, :create]

  def new

  end

  def create
    if (params[:session].nil?)
      facebook
    else
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

  end


# FACEBOOK
  def facebook
    auth = request.env["omniauth.auth"]
    @user = User.find_by(email: auth.info.email)
    if @user.nil? 
      facebook_sign_in
      session[:user_id] = @user.id
      render 'facebook'
    else
      session[:user_id] = @user.id
      redirect_to url_for(:controller => 'folders', :action => ACTION_INDEX)
    end
  end

  def facebook_sign_in
    auth = request.env["omniauth.auth"]
    username = auth.info.name + '_'
    password = SecureRandom.urlsafe_base64
    @user = User.new({username: username, first_name: auth.info.first_name,last_name: 
                          auth.info.last_name, email: auth.info.email, password: password,
                           password_confirmation: password })
    @user.save!
    User.create_main_folder(@user)
    @user
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
