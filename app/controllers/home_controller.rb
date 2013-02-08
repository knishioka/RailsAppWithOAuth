class HomeController < ApplicationController
  def index
    unless current_user
      render :welcome
    end
  end
end
