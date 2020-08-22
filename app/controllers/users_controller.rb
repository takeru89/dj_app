class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cache_buster

  def show
    @nickname = current_user.nickname
    @words = current_user.words.page(params[:page]).per(10)
  end

  private

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
