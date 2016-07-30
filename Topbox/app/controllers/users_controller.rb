class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Conta criada com sucesso!'
      redirect_to '/'
    else
      flash[:danger] = 'Email em já em uso.' unless used_email?
      flash[:danger] = 'Nome de usuário já em uso.' if used_username?
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end

  def used_email?
    if User.find_by_email(:email).nil?
      return false
    else
      return true
    end
  end

end