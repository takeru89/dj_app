require 'rails_helper'

RSpec.describe 'お気に入り機能', type: :system do
  before do
    @word = FactoryBot.create(:word)
    @another_user = User.create(nickname: "another", email: "another@another.com", password: "another2020", password_confirmation: "another2020")
  end
  context 'お気に入り登録・解除ができるとき'do
    it 'ログインしたユーザーは検索一覧からお気に入り登録・解除ができる' do
      # ログインする
      sign_in(@another_user)
      # 検索フォームを入力し、検索ボタンを押す
      select "forward match", from: :search_method
      fill_in 'search_word', with: "りんご"
      find(".search-button").click
      # 検索結果一覧に検索語彙が表示されることを確認する
      expect(page).to have_content(@word.kana)
      # 検索結果一覧にお気に入りボタンが表示されることを確認する
      expect(page).to have_selector(".star-button")
      # お気に入りボタンを押す
      find(".star-button").click
      # 送信するとFavoriteモデルのカウントが1上がることを確認する
      expect {
        expect(current_path).to eq search_words_path
        expect(page).to have_content("りんご")
      }.to change { Favorite.count }.by(1)
      # お気に入りボタンをもう一度押す
      find(".star-button").click
      # 送信するとFavoriteモデルのカウントが1下がることを確認する
      expect {
        expect(current_path).to eq search_words_path
        expect(page).to have_content("りんご")
      }.to change { Favorite.count }.by(-1)
      # お気に入り一覧画面に反映されていることを確認
    end
    it 'ログインしたユーザーは語彙詳細画面からお気に入り登録・解除ができる' do
      # ログインする
      sign_in(@another_user)
      # 検索フォームを入力し、検索ボタンを押す
      select "forward match", from: :search_method
      fill_in 'search_word', with: "りんご"
      find(".search-button").click
      # 検索結果一覧に検索語彙が表示されることを確認する
      expect(page).to have_content(@word.kana)
      # 語彙をクリックする
      find(".search-result-piece").click
      # 詳細画面にお気に入りボタンが表示されることを確認する
      expect(page).to have_selector(".star-button")
      # お気に入りボタンを押す
      find(".star-button").click
      # 送信するとFavoriteモデルのカウントが1上がることを確認する
      expect {
        expect(current_path).to eq word_path(@word.id)
        expect(page).to have_content("りんご")
      }.to change { Favorite.count }.by(1)
      # お気に入りボタンをもう一度押す
      find(".star-button").click
      # 送信するとFavoriteモデルのカウントが1下がることを確認する
      expect {
        expect(current_path).to eq word_path(@word.id)
        expect(page).to have_content("りんご")
      }.to change { Favorite.count }.by(-1)
    end
    it 'ログインしたユーザーは自身の投稿語彙の一覧からもお気に入り登録・解除ができる' do
      # ログインする
      sign_in(@word.user)
      # マイページボタンのドロップダウンに"My Posts"が存在することを確認する
      expect(
        find(".my-page-lists").hover
      ).to have_content('My Posts')
      # "My Posts"をクリック
      click_on("My Posts")
      # マイ投稿一覧に自身の投稿語彙が存在することを確認
      expect(page).to have_content(@word.kana)
      # お気に入りボタンが表示されることを確認する
      expect(page).to have_selector(".star-button")
      # お気に入りボタンを押す
      find(".star-button").click
      # 送信するとFavoriteモデルのカウントが1上がることを確認する
      expect {
        expect(page).to have_content(@word.kana)
      }.to change { Favorite.count }.by(1)
      # お気に入りボタンをもう一度押す
      find(".star-button").click
      # 送信するとFavoriteモデルのカウントが1下がることを確認する
      expect {
        expect(page).to have_content(@word.kana)
      }.to change { Favorite.count }.by(-1)
    end
    it 'ログインしたユーザーはお気に入り一覧からお気に入り解除ができる' do
      # ログインする
      sign_in(@another_user)
      # 検索フォームを入力し、検索ボタンを押す
      select "forward match", from: :search_method
      fill_in 'search_word', with: "りんご"
      find(".search-button").click
      # お気に入りボタンを押す
      find(".star-button").click
      # マイページボタンのドロップダウンに"My Favorites"が存在することを確認する
      expect(
        find(".my-page-lists").hover
      ).to have_content('My Favorites')
      # "My Favorites"をクリック
      click_on("My Favorites")
      # お気に入り一覧に先ほどのお気に入り登録語彙が存在することを確認
      expect(page).to have_content(@word.kana)
      # お気に入りボタンが表示されることを確認する
      expect(page).to have_selector(".star-button")
      # お気に入りボタンを押す
      find(".star-button").click
      # Favoriteモデルのカウントが1下がることを確認する
      expect {
        expect(page).to have_no_content(@word.kana)
      }.to change { Favorite.count }.by(-1)
    end
  end
  context 'お気に入り登録・解除ができないとき'do
    it 'ログインしていないとお気に入り登録・解除ができない' do
      #トップページへ遷移する
      visit root_path
      # 検索フォームを入力し、検索ボタンを押す
      select "forward match", from: :search_method
      fill_in 'search_word', with: "りんご"
      find(".search-button").click
      # 検索結果一覧に検索語彙が表示されることを確認する
      expect(page).to have_content(@word.kana)
      # 検索結果一覧にお気に入りボタンが存在しないことを確認する
      expect(page).to have_no_selector(".star-button")
      # 語彙をクリックする
      find(".search-result-piece").click
      # 詳細画面にお気に入りボタンが表示されることを確認する
      expect(page).to have_no_selector(".star-button")
    end
  end
end
