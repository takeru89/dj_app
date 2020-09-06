class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cache_buster

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @nickname = current_user.nickname
    @words = if params[:sort_method] == 'sort_created_asc'
               current_user.words.order(created_at: 'ASC').page(params[:page]).per(10)
             elsif params[:sort_method] == 'kana_asc'
               current_user.words.order(kana: 'ASC').page(params[:page]).per(10)
             elsif params[:sort_method] == 'kana_desc'
               current_user.words.order(kana: 'DESC').page(params[:page]).per(10)
             else
               current_user.words.order(created_at: 'DESC').page(params[:page]).per(10)
             end
  end

  private

  def set_cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
