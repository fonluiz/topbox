class HomesController < ApplicationController

  def new
    require_user
  end

end
