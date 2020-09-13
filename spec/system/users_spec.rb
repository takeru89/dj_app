require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動
      visit root_path
      # トップページにサインアップボタンがある
      expect(page).to have_content('Sign Up')
      # 新規登録ページへ遷移
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Confirm password', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移
      expect(current_path).to eq root_path
      # 鍵アイコンにカーソルを合わせるとログアウト、エディット、デリートが表示される
      expect(
        find(".sub-out-lists").hover
      ).to have_content('Logout')
      expect(
        find(".sub-out-lists").find(".sub-out").hover
      ).to have_content('Edit')
      expect(
        find(".sub-out-lists").find(".sub-out").hover
      ).to have_content('Delete')
      # サインアップボタンや、ログインボタンが表示されていない
      expect(page).to have_no_content('Sign Up')
      expect(page).to have_no_content('Login')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('Sign Up')
      # 新規登録ページへ遷移
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'Nickname', with: ""
      fill_in 'Email', with: ""
      fill_in 'Password', with: ""
      fill_in 'Confirm password', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻される
      expect(current_path).to eq "/users"
    end
  end
  context 'ユーザー新規登録をキャンセルするとき' do
    it 'フォーム下部のロゴをクリックすると、トップページへ遷移する' do
      # トップページに移動
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('Sign Up')
      # 新規登録ページへ遷移
      visit new_user_registration_path
      # ロゴをクリック
      find('.sign-up-bottom-logo').click
      # トップページへ遷移
      visit root_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動
      visit root_path
      # トップページにログインページへ遷移するボタンがある
      expect(page).to have_content('Login')
      # ログインページへ遷移
      visit new_user_session_path
      # ユーザー情報を入力
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      visit root_path
      # 鍵アイコンにカーソルを合わせるとカーソルを合わせるとログアウト、エディット、デリートが表示される
      expect(
        find(".sub-out-lists").hover
      ).to have_content('Logout')
      expect(
        find(".sub-out-lists").find(".sub-out").hover
      ).to have_content('Edit')
      expect(
        find(".sub-out-lists").find(".sub-out").hover
      ).to have_content('Delete')
      # サインアップボタンやログインボタンが表示されていない
      expect(page).to have_no_content('Sign Up')
      expect(page).to have_no_content('Login')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動
      visit root_path
      # トップページにログインボタンがある
      expect(page).to have_content('Login')
      # ログインページへ遷移
      visit new_user_session_path
      # ユーザー情報を入力
      fill_in 'Email', with: ""
      fill_in 'Password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻される
      expect(current_path).to eq new_user_session_path
    end
  end
  context 'ログインをキャンセルするとき' do
    it 'フォーム下部のロゴをクリックすると、トップページへ遷移する' do
      # トップページに移動
      visit root_path
      # トップページにログインボタンがある
      expect(page).to have_content('Login')
      # 新規登録ページへ遷移
      visit new_user_session_path
      # ロゴをクリック
      find('.login-bottom-logo').click
      # トップページへ遷移
      visit root_path
    end
  end
end
