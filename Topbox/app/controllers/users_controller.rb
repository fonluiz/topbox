class UsersController < ApplicationController
  before_action :save_login_state, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      create_main_folder(@user)
      flash[:success] = 'Conta criada com sucesso!'
      redirect_to '/login'
    else
      flash.now[:danger] = 'Email já em uso.' if used_email?
      flash.now[:danger] = 'Nome de usuário já em uso.' if used_username?
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

  private
  def create_main_folder(user)
    @folder = Folder.create(name: 'My TopBox', parent: nil , user: user)
    @folder.save(validate: false)
  end

end