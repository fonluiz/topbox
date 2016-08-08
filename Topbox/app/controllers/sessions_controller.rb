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
      redirect_to_mytopbox
    else
      flash.now[:danger] = INVALID_AUTHENTICATION_ERROR
      render :new
    end
  end

  def destroy
    log_out
    redirect_to :action => ACTION_NEW
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
