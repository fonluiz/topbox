class UsersController < ApplicationController
  include UsersHelper, ApplicationHelper
  before_action :has_active_session?, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_user_params)
    if @user.save
      create_main_folder(@user)
      flash[:success] = t(:account_msg)
      redirect_to LOGIN_URL
    else
      verify_error
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(get_user_params)
      flash[:success] = "Profile updated"
      redirect_to_mytopbox
    else
      render :edit
    end
  end

  private
  def get_user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end

  def verify_error
    if empty_field?
      flash.now[:danger] = t(:empty_field)
    elsif used_username?
      flash.now[:danger] = t(:username_used_msg)
    elsif short_username?
      flash.now[:danger] = t(:short_username)
    elsif used_email?
      flash.now[:danger] = t(:email_used_msg)
    elsif email_error?
      flash.now[:danger] = t(:email_error)
    elsif not_confirmed_password
      flash.now[:danger] = t(:password_not_confirmed)
    else flash.now[:danger] = t(:username_used_msg)
    end
  end

  def empty_field?
    if ( (params[:user][:first_name].empty?) or
         (params[:user][:last_name.empty?]) or
         (params[:user][:username].empty?) or
         (params[:user][:email].empty?) or
         (params[:user][:password].empty?) or
        (params[:user][:password_confirmation].empty?)
         )

      #retorna verdadeiro se algum campo estiver vazio
      return true
    else
      return false
    end

  end

  def short_username?
    params[:user][:username].size < 6
  end

  def email_error?
    email = params[:user][:email]

    if (email.include? '@')
      i = email.index('@')
      if i+1 == email.size
        return true
      else
        return false
      end
    else
      return true
    end
  end

  def used_email?
    User.exists?(email: @user.email)
  end

  def used_username?
    User.exists?(username: @user.username)
  end

  def not_confirmed_password
    (params[:user][:password] != params[:user][:password_confirmation])
  end

  def create_main_folder(user)
    unless (user.nil?)
      @folder = Folder.create(name: MAIN_FOLDER_NAME, parent: nil , user: user)
      @folder.save(validate: false)
    end 
  end
end