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
      flash[:success] = ACCOUNT_CREATED_MSG
      redirect_to LOGIN_URL
    else
      flash.now[:danger] = EMAIL_USED_MSG if used_email?
      flash.now[:danger] = USERNAME_USED_MSG if used_username?
      flash.now[:danger] = PASSWORD_NOT_CONFIRMED if not_confirmed_password
      render :new
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update(get_user_params)
     render :edit
    else
     render :edit
    end
  end

  private
  def get_user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end

  def used_email?
    User.exists?(email: @user.email)
  end

  def used_username?
    User.exists?(username: @user.username)
  end

  def not_confirmed_password
    return (params[:user][:password] != params[:user][:password_confirmation])
  end

  def create_main_folder(user)
    unless (user.nil?)
      @folder = Folder.create(name: MAIN_FOLDER_NAME, parent: nil , user: user)
      @folder.save(validate: false)
    end 
  end

end