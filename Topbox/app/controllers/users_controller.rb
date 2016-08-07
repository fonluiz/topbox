class UsersController < ApplicationController
  include UsersHelper, ApplicationHelper
  before_action :has_active_session?, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_main_folder(@user)
      flash[:success] = ACCOUNT_CREATED_MSG
      redirect_to LOGIN_URL
    else
      flash.now[:danger] = EMAIL_USED_MSG if used_email?
      flash.now[:danger] = USERNAME_USED_MSG if used_username?
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end

  def used_email?
    User.exists?(email: @user.email)
  end

  def used_username?
    User.exists?(username: @user.username)
  end

  def create_main_folder(user)
    @folder = Folder.create(name: MAIN_FOLDER_NAME, parent: nil , user: user)
    @folder.save(validate: false)
  end

end