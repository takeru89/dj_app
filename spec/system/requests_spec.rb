require 'rails_helper'

RSpec.describe 'リクエスト投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'リクエスト投稿ができるとき'do
    it 'ログインしたユーザーは語彙投稿できる' do
      # ログインする
      sign_in(@user)
      # リクエストボードが存在することを確認
      expect(page).to have_content("Requested Words")
      # フォームを入力する
      fill_in 'request_word', with: "バナナ"
      # 送信すると一覧に内容が表示され、Requestモデルのカウントが1上がることを確認する
      expect{
        find('.request-button').click
        expect(page).to have_content("バナナ")
      }.to change { Request.count }.by(1)
    end
  end
  context 'リクエスト投稿ができないとき'do
    it 'ログインしていないとリクエスト投稿が表示されない' do
      #トップページへ遷移する
      visit root_path
      # リクエストボードが存在しないことを確認
      expect(page).to have_no_content("Requested Words")
    end
  end
end