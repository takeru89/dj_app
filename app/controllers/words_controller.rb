class WordsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_word, only: [:show, :edit, :update, :destroy,
                                  :myword_update, :myword_destroy]
  before_action :set_cache_buster


  def index
    @words = Word.includes(:user).order('created_at DESC').limit(200)
    @requests = Request.wrequest.order('created_at DESC')
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to root_path
    else
      render new_word_path
    end
  end

  def show
    @favorite = Favorite.find_by(word_id: @word.id)
    @delete_path = if request.referer.include?('/users/')
                     myword_destroy_word_path(@word.id)
                   else
                     word_path(@word.id)
                   end
  end

  def edit
    @path = if request.referer.include?('/users/')
              myword_update_word_path(@word.id)
            else
              word_path(@word.id)
            end
  end

  def update
    if @word.update(word_params)
      redirect_to @word
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
      redirect_to root_path
    else
      flash.now[:alert] = 'Delete Failed'
      render @word
    end
  end

  def search
    method = params[:search_method]
    @word = params[:search_word]
    @words = Word.search(method, @word).page(params[:page]).per(10)
  end

  def myword_update
    if @word.update(word_params)
      redirect_to user_path(@word.user_id)
    else
      render :edit
    end
  end

  def myword_destroy
    if @word.destroy
      redirect_to user_path(@word.user_id)
    else
      flash.now[:alert] = 'Delete Failed'
      render @word
    end
  end

  private

  def word_params
    params.require(:word).permit(:kana, :kanji, :english, :word_class_id, :explanation, :image).merge(user_id: current_user.id)
  end

  def set_word
    @word = Word.find(params[:id])
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
