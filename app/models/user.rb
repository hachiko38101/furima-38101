class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  zenkaku = /\A[ぁ-んァ-ン一-龥]+\z/
  katakana = /\A[ァ-ヶー－]+\z/

  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は英数混合でご入力ください' }, allow_blank: true
  validates :nickname, presence: true
  validates :first_name_kanji, presence: true
  validates :first_name_kanji, format: { with: zenkaku, message: 'は全角でご入力ください' }, allow_blank: true
  validates :last_name_kanji, presence: true
  validates :last_name_kanji, format: { with: zenkaku, message: 'は全角でご入力ください' }, allow_blank: true
  validates :first_name_kana, presence: true
  validates :first_name_kana, format: { with: katakana, message: 'は全角カナでご入力ください' }, allow_blank: true
  validates :last_name_kana, presence: true
  validates :last_name_kana, format: { with: katakana, message: 'は全角カナでご入力ください' }, allow_blank: true
  validates :birth_day, presence: true

  has_many :items
  has_many :purchases
end
