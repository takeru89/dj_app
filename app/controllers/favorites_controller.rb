class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = Favorite.where(user_id: current_user.id)
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
end
