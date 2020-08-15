require 'rails_helper'
describe Word do
  before do
    @word = FactoryBot.build(:word)
    @word.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '語彙登録' do
    context '語彙登録がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@word).to be_valid
      end

      it 'kanjiとimageがなくても登録できる' do
        @word.kanji = nil
        @word.image = nil
        expect(@word).to be_valid
      end
    end

    context '語彙登録がうまくいかないとき' do
      it 'kanaが空だと登録できない' do
        @word.kana = nil
        @word.valid?
        expect(@word.errors.full_messages).to include("Kana can't be blank")
      end

      it 'kanaに仮名以外の文字が入ると登録できない' do
        vocab = %w[ringo 林檎]
        vocab.each do |v|
          @word.kana = v
          @word.valid?
          expect(@word.errors.full_messages).to include('Kana is invalid')
        end
      end

      it 'kanjiに漢字が1字以上入っていないと登録できない' do
        vocab = %w[りんご リンゴ]
        vocab.each do |v|
          @word.kanji = v
          @word.valid?
          expect(@word.errors.full_messages).to include('Kanji is invalid')
        end
      end

      it 'kanjiに英数字が入っていると登録できない' do
        vocab = %w[林5 林go]
        vocab.each do |v|
          @word.kanji = v
          @word.valid?
          expect(@word.errors.full_messages).to include('Kanji is invalid')
        end
      end

      it 'englishが空だと投稿できない' do
        @word.english = nil
        @word.valid?
        expect(@word.errors.full_messages).to include("English can't be blank")
      end

      it 'englishに漢字仮名が含まれると登録できない' do
        vocab = %w[appる appル app檎]
        vocab.each do |v|
          @word.english = v
          @word.valid?
          expect(@word.errors.full_messages).to include('English is invalid')
        end
      end

      it 'word_class_idが空だと登録できない' do
        @word.word_class_id = nil
        @word.valid?
        expect(@word.errors.full_messages).to include("Word class can't be blank")
      end

      it 'word_class_idが1だと登録できない' do
        @word.word_class_id = 1
        @word.valid?
        expect(@word.errors.full_messages).to include("Word class can't be blank")
      end

      it 'explanationが空だと登録できない' do
        @word.explanation = nil
        @word.valid?
        expect(@word.errors.full_messages).to include("Explanation can't be blank")
      end
    end
  end
end
