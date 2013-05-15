class HomeController < ApplicationController
  include SkinHelper

  def index
    @users = User.all
  end

end
