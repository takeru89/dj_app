require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録' do
    context '新規登録がうまくいくとき' do
      it "全ての項目が存在すれば登録できる" do
        expect(@user).to be_valid
      end

      it "passwordが8文字以上あれば登録できる" do
        @user.password = "a1a1a1a1"
        @user.password_confirmation = "a1a1a1a1"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空だと登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@や.がないと登録できない" do
        e_ad = ["samplesamplecom", "sample@samplecom", "samplesample.com"]
        e_ad.each do |e|
          @user.email = e
          @user.valid?
          expect(@user.errors.full_messages).to include("Email is invalid")
        end
      end

      it "emailが半角英数字でないと登録できない" do
        e_ad = ["sample１１１@sample.com", "サンプル@sample.com"]
        e_ad.each do |e|
          @user.email = e
          @user.valid?
          expect(@user.errors.full_messages).to include("Email is invalid")
        end
      end

      it "すでに登録されたemailだと登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空だと登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが8文字未満では登録できない" do
        @user.password = "1a1a1a1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      end

      it "passwordが半角英数字混合出ないと登録できない" do
        pw = ["11111111", "aaaaaaaa", "１１１１１１１１", "ああああああああ"]
        pw.each do |p|
          @user.password = p
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is invalid")
        end
      end

      it "password_confirmationが空だと登録できない" do
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it "password_confirmationがpasswordと同じではないと登録できない" do
        @user.password_confirmation = "2b2b2b2b"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
