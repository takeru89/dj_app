require 'rails_helper'
describe Request do
  before do
    @request = FactoryBot.build(:request)
  end

  describe 'リクエスト登録' do
    context 'リクエスト登録がうまくいくとき' do
      it 'request_wordがあれば登録できる' do
        expect(@request).to be_valid
      end

      it 'リクエストが50字以内であれば登録できる' do
        @request.request_word = 'a' * 50
        expect(@request).to be_valid
      end
    end

    context '語彙登録がうまくいかないとき' do
      it 'request_wordが空だと登録できない' do
        @request.request_word = nil
        @request.valid?
        expect(@request.errors.full_messages).to include("Request word can't be blank")
      end

      it 'request_wordが51字以上だと登録できない' do
        @request.request_word = 'a' * 51
        @request.valid?
        expect(@request.errors.full_messages).to include('Request word is too long (maximum is 50 characters)')
      end
    end
  end
end
