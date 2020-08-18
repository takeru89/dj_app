class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @nickname = current_user.nickname
    @words = current_user.words.page(params[:page]).per(10)
  end
end
