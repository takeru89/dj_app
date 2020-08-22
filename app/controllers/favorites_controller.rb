class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cache_buster

  def index
    @favorites = Favorite.where(user_id: current_user.id).includes(:word).page(params[:page]).per(10)
  end

  def create
    @word = Word.find(params[:word_id])
    @favorite = Favorite.new(user_id: current_user.id, word_id: @word.id)
    @favorite.save
  end

  def destroy
    @word = Word.find(params[:word_id])
    @favorite = Favorite.find_by(word_id: @word.id)
    @favorite.destroy
  end

  private

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
