module SignInSupport
  def basic_pass(path)
    username = ENV['BASIC_AUTH_USER']
    password = ENV['BASIC_AUTH_PASSWORD']
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  def sign_in(user)
    @user = FactoryBot.build(:user)
    basic_pass root_path
    visit root_path
    expect(page).to have_content('新規登録')
    expect(page).to have_content('ログイン')
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
    expect{
      find('input[name="commit"]').click
    }.to change { User.count }.by(1)
    expect(current_path).to eq(root_path)
  end
end