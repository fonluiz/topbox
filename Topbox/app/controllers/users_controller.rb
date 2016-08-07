class UsersController < ApplicationController
  before_action :save_login_state, only: [:new, :create]
  skip_before_filter :show_navbar, only: [:new]

  #Creates a new user instance.
  def new
    @user = User.new
  end

  #Creates a new user if the username and email typped aren't already at the database.
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

  #Define the required arguments for creating a use, that are: first name, last name, username, email and password.
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end

  #Verify if an email is already in use.
  def used_email?
    User.exists?(email: @user.email)
  end

  #Verify if an username is already in use.
  def used_username?
    User.exists?(username: @user.username)
  end

  #
  private
  def create_main_folder(user)
    @folder = Folder.create(name: 'My TopBox', parent: nil , user: user)
    @folder.save(validate: false)
  end

end