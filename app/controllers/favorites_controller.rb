class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def create
    @word = Word.find(params[:word_id])
    @favorite = Favorite.new(user_id: current_user.id, word_id: @word.id)
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
  end
end
