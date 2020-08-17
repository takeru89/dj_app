class Word < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_many :likes
  belongs_to_active_hash :word_class
  has_one_attached :image

  KANA_REGEX = /\A[ぁ-んァ-ヶー－]+\z/.freeze
  KANJI_REGEX = /\A[ぁ-んァ-ン一-龥ー－]*?[一-龥]+[ぁ-んァ-ン一-龥ー－]*?\z/.freeze
  ENGLISH_REGEX = /\A[a-zA-Z\-]+\z/.freeze

  with_options presence: true do
    validates :kana, format: { with: KANA_REGEX }
    validates :english, format: { with: ENGLISH_REGEX }
    validates :word_class_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :explanation, length: { maximum: 2000 }
  end
  validates :kanji, format: { with: KANJI_REGEX }, if: proc { |word| word.kanji.present? }

  def self.search(method, word)
    if method == "forward_match"
      @words = Word.where('kana LIKE(?) OR kanji LIKE(?) OR english LIKE(?)', "#{word}%", "#{word}%", "#{word}%")
    elsif method == "backward_match"
      @words = Word.where('kana LIKE(?) OR kanji LIKE(?) OR english LIKE(?)', "%#{word}", "%#{word}", "%#{word}")
    elsif method == "partial_match"
      @words = Word.where('kana LIKE(?) OR kanji LIKE(?) OR english LIKE(?)', "%#{word}%", "%#{word}%", "%#{word}%")
    elsif method == "exact_match"
      @words = Word.where('kana LIKE(?) OR kanji LIKE(?) OR english LIKE(?)', "#{word}", "#{word}", "#{word}")
    else
      @words = Word.all
    end
  end
end
