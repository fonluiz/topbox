class HomeController < ApplicationController

  def new
    require_user
  end
end
