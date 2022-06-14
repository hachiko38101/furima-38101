module SignInSupport
  def sign_in(user)
    basic_pass root_path
    visit root_path
    expect(page).to have_content('新規登録')
    expect(page).to have_content('ログイン')
    visit new_user_registration_path
    fill_in 'nickname', with: @user.nickname
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    fill_in 'password confirmation', with: @user.password
    fill_in 'first-name', with: @user.first_name_kanji
    fill_in 'last-name', with: @user.last_name_kanji
    fill_in 'first-name-kana', with: @user.first_name_kana
    fill_in 'last-name-kana', with: @user.last_name_kana
    fill_in 'user_birth_day_1i', with: @user.birth_day.year
    fill_in 'user_birth_day_2i', with: @user.birth_day.month
    fill_in 'user_birth_day_3i', with: @user.birth_day.day
    expect{
      find('input[name="commit"]').click
    }.to change { User.count }.by(1)
  end
end