require 'rails_helper'

RSpec.describe '語彙投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '語彙投稿ができるとき'do
    it 'ログインしたユーザーは語彙投稿できる' do
      # ログインする
      sign_in(@user)
      # 語彙投稿ページボタンがあることを確認する
      expect(page).to have_selector(".post-link")
      # 投稿ページに移動する
      visit new_word_path
      # フォームに情報を入力する
      fill_in 'kana', with: "りんご"
      fill_in 'kanji', with: "林檎"
      fill_in 'english', with: "apple"
      select "noun", from: "word class"
      fill_in 'explanation', with: "林檎"
      # 送信するとWordモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Word.count }.by(1)
      # マイ投稿一覧ページに遷移
      visit user_path(@user.id)
      # マイ投稿一覧ページに投稿した内容のツイートが存在することを確認する
      expect(page).to have_content("りんご")
      expect(page).to have_content("林檎")
      expect(page).to have_content("apple")
      # ロゴをクリックする
      find(".header-left-contents").click
      # トップページへ遷移する
      visit root_path
      # トップページのタグクラウドに投稿した語彙が存在することを確認する
      expect(page).to have_content("りんご")
    end
  end
  context '語彙投稿ができないとき'do
    it 'ログインしていないと語彙投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがないことを確認する
      expect(page).to have_no_selector(".post-link")
    end
  end
end

RSpec.describe '語彙検索・詳細閲覧', type: :system do
  before do
    @word = FactoryBot.create(:word)
    @another_user = User.create(nickname: "another", email: "another@another.com", password: "another2020", password_confirmation: "another2020")
  end
  it 'ログインしたユーザーは語彙検索・詳細閲覧できる' do
    # ログインする
    sign_in(@word.user)
    # 検索フォームを入力し、検索ボタンを押す
    select "forward match", from: :search_method
    fill_in 'search_word', with: "りんご"
    find(".search-button").click
    # 検索結果一覧に検索語彙が表示されることを確認する
    expect(page).to have_content(@word.kana)
    # 検索結果一覧にお気に入りボタンが表示されることを確認する
    expect(page).to have_selector(".star-button")
    # 語彙をクリックする
    find(".search-result-piece").click
    # 詳細ページにクリックした語彙の内容が存在することを確認
    expect(page).to have_content(@word.kana)
    expect(page).to have_content(@word.kanji)
    expect(page).to have_content(@word.english)
    expect(page).to have_content(@word.word_class_id)
    expect(page).to have_content(@word.explanation)
    # 詳細ページにお気に入りボタンが表示されることを確認する
    expect(page).to have_selector(".star-button")
  end
  it 'ログインしていない状態では検索はできるがお気に入りボタンは表示されない' do
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
    # 詳細ページにクリックした語彙の内容が存在することを確認
    expect(page).to have_content(@word.kana)
    expect(page).to have_content(@word.kanji)
    expect(page).to have_content(@word.english)
    expect(page).to have_content(@word.word_class_id)
    expect(page).to have_content(@word.explanation)
    # 詳細ページにお気に入りボタンが存在しないことを確認する
    expect(page).to have_no_selector(".star-button")
  end
end

RSpec.describe '語彙編集', type: :system do
  before do
    @word = FactoryBot.create(:word)
    @another_user = User.create(nickname: "another", email: "another@another.com", password: "another2020", password_confirmation: "another2020")
  end
  context '語彙編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した語彙の編集ができる' do
      # 語彙を投稿したユーザーでログインする
      sign_in(@word.user)
      # トップページに投稿語彙が表示されていることを確認する
      expect(page).to have_content(@word.kana)
      # 詳細ページへ遷移する
      visit word_path(@word.id)
      # 編集ボタンが表示されていることを確認する
      expect(page).to have_selector(".edit-word-button")
      # 編集ページへ遷移する
      visit edit_word_path(@word.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('.kana-text').value
      ).to eq @word.kana
      expect(
        find('.kanji-text').value
      ).to eq @word.kanji
      expect(
        find('.english-text').value
      ).to eq @word.english
      expect(
        find('.class-select').value
      ).to eq @word.word_class_id.to_s
      expect(
        find('.explanation-text').value
      ).to eq @word.explanation
      # 投稿内容を編集する
      fill_in 'kana', with: "#{@word.kana}へんしゅう"
      fill_in 'kanji', with: "#{@word.kanji}編集"
      fill_in 'english', with: "#{@word.english}edit"
      select "verb", from: "word class"
      fill_in 'explanation', with: "#{@word.explanation}編集"
      # 編集してもWordモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Word.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq word_path(@word.id)
      # 詳細ページに変更内容が反映されていることを確認する
      expect(page).to have_content("#{@word.kana}へんしゅう")
      expect(page).to have_content("#{@word.kanji}編集")
      expect(page).to have_content("#{@word.english}edit")
      expect(page).to have_content("verb")
      expect(page).to have_content("#{@word.explanation}編集")
      # トップページに遷移する
      visit root_path
      # トップページに変更した内容の語彙が存在することを確認する
      expect(page).to have_content("#{@word.kana}へんしゅう")
      # マイ投稿一覧ページへ遷移する
      visit user_path(@word.user.id)
      # マイ投稿一覧ページに変更した内容の語彙が存在することを確認する
      expect(page).to have_content("#{@word.kana}へんしゅう")
      expect(page).to have_content("#{@word.kanji}編集")
      expect(page).to have_content("#{@word.english}edit")
    end
  end
  context '語彙編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # 他ユーザーでログインする
      sign_in(@another_user)
      # 語彙詳細ページへ遷移する
      visit word_path(@word.id)
      # 編集ボタンがないことを確認する
      expect(page).to have_no_selector(".edit-word-button")
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページに遷移する
      visit root_path
      # 語彙詳細ページへ遷移
      visit word_path(@word.id)
      # 編集ボタンがないことを確認する
      expect(page).to have_no_selector(".edit-word-button")
    end
  end
end

RSpec.describe '語彙削除', type: :system do
  before do
    @word = FactoryBot.create(:word)
    @another_user = User.create(nickname: "another", email: "another@another.com", password: "another2020", password_confirmation: "another2020")
  end
  context '語彙削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した語彙の削除ができる' do
      # 語彙を投稿したユーザーでログインする
      sign_in(@word.user)
      # 語彙詳細画面に遷移する
      visit word_path(@word.id)
      # 削除ボタンがあることを確認する
      expect(page).to have_selector(".delete-word-button")
      # 削除ボタンをクリックする
      find('.delete-word-button').click
      # 削除確認メッセージが表示され、OKを押すと削除される
      expect {
        expect(page.driver.browser.switch_to.alert.text).to eq "Do you really want to delete this word-info?"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_no_content(@word.kana)
      }.to change { Word.count }.by(-1)
      # マイ投稿一覧ページへ遷移したことを確認する
      expect(current_path).to eq user_path(@word.user.id)
      # 削除した語彙の内容が存在しないことを確認する
      expect(page).to have_no_content(@word.kana)
      expect(page).to have_no_content(@word.kanji)
      expect(page).to have_no_content(@word.english)
      #トップページへ遷移する
      visit root_path
      # トップページに削除した語彙の内容が存在しないことを確認する
      expect(page).to have_no_content(@word.kana)
    end
  end
  context '語彙削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した語彙の削除ができない' do
      # 他ユーザーでログインする
      sign_in(@another_user)
      # 語彙詳細画面に遷移する
      visit word_path(@word.id)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_selector(".delete-word-button")
    end
    it 'ログインしていないと語彙の削除ボタンがない' do
      # トップページに遷移する
      visit root_path
      # 語彙詳細画面へ遷移する
      visit word_path(@word.id)
      # 削除ボタンが無いことを確認する
      expect(page).to have_no_selector(".delete-word-button")
    end
  end
end

