class WordsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_word, only: [:show, :edit, :update]

  def index
    @words = Word.includes(:user).order('created_at DESC').limit(200)
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
  end

  def edit
  end

  def update
    if @word.update(word_params)
      redirect_to @word
    else
      render :edit
    end
  end

  private

  def word_params
    params.require(:word).permit(:kana, :kanji, :english, :word_class_id, :explanation, :image).merge(user_id: current_user.id)
  end

  def set_word
    @word = Word.find(params[:id])
  end
end
