class HomeFoldersController < ApplicationController

  def new
    require_user
  end

end
