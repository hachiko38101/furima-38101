require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nicknameとemail、passwordとpassword_confirmation、first_name_kanjiとlast_name_kanji、first_name_kanaとlast_name_kana、birth_dayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation ="123456"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must be alphanumeric characters and include both letters and numbers')
      end

      it 'passwordが英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation ="abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must be alphanumeric characters and include both letters and numbers')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = "アイウエオ1b"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must be alphanumeric characters and include both letters and numbers')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'first_name_kanjiが空では登録できない' do
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji can't be blank")
      end

      it 'last_name_kanjiが空では登録できない' do
        @user.last_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
      end

      it 'first_name_kanjiが半角では登録できない' do
        @user.first_name_kanji = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanji Input full-width characters')
      end

      it 'last_name_kanjiが半角では登録できない' do
        @user.last_name_kanji = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanji Input full-width characters')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaがカタカナでなければ登録できない' do
        @user.first_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Input full-width katakana characters')
      end

      it 'last_name_kanaがカタカナでなければ登録できない' do
        @user.last_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Input full-width katakana characters')
      end

      it 'birth_dayが空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
