class FavoritesController < ApplicationController
  before_action :authenticate_user!

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

  def reload
    redirect_to action: :index
  end
end
