require 'csv'

class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cache_buster

  def index
    fav = Favorite.where(user_id: current_user.id).includes(:word)
    @favorites = if params[:sort_method] == 'sort_created_asc'
                   fav.order(created_at: 'ASC').page(params[:page]).per(10)
                 elsif params[:sort_method] == 'kana_asc'
                   fav.order('words.kana ASC').page(params[:page]).per(10)
                 elsif params[:sort_method] == 'kana_desc'
                   fav.order('words.kana DESC').page(params[:page]).per(10)
                 else
                   fav.order(created_at: 'DESC').page(params[:page]).per(10)
                 end

    respond_to do |format|
      format.html
      format.csv do |_csv|
        send_favorites_csv(@favorites)
      end
    end
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
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def send_favorites_csv(favorites)
    csv_data = CSV.generate do |csv|
      header = %w[kana kanji class english detail]
      csv << header

      favorites.each do |favorite|
        values = [favorite.word.kana, favorite.word.kanji, favorite.word.word_class.name, favorite.word.english, favorite.word.explanation]
        csv << values
      end
    end
    send_data(csv_data, filename: 'dj_favorites.csv')
  end
end
