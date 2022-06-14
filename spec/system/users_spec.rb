require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      basic_pass root_path
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password
      fill_in 'first-name', with: @user.first_name_kanji
      fill_in 'last-name', with: @user.last_name_kanji
      fill_in 'first-name-kana', with: @user.first_name_kana
      fill_in 'last-name-kana', with: @user.last_name_kana
      select @user.birth_day.year, from: 'user[birth_day(1i)]'
      select @user.birth_day.month, from: 'user[birth_day(2i)]'
      select @user.birth_day.day, from: 'user[birth_day(3i)]'
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      basic_pass root_path
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name-kana', with: ''
      fill_in 'last-name-kana', with: ''
      select '--', from: 'user[birth_day(1i)]'
      select '--', from: 'user[birth_day(2i)]'
      select '--', from: 'user[birth_day(3i)]'
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      basic_pass root_path
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      basic_pass root_path
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      find('input[name="commit"]').click
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'ログアウト', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログアウトができるとき' do
    it 'ログイン状態からログアウトする事ができる' do
      basic_pass root_path
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
      find_link('ログアウト', href: destroy_user_session_path).click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
  end
end
