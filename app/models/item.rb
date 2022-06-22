class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :image, presence: { message: 'の添付が必要です' }
  validates :name, presence: { message: "は空欄では登録できません"} 
  validates :explanation, presence: { message: "は空欄では登録できません"}

  validates :category_id, numericality: { other_than: 1, message: "は空欄では登録できません"} 
  validates :condition_id, numericality: { other_than: 1 , message: "は空欄では登録できません"} 
  validates :delivery_charge_id, numericality: { other_than: 1 , message: "は空欄では登録できません"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "は空欄では登録できません"}
  validates :shipping_day_id, numericality: { other_than: 1 , message: "は空欄では登録できません"}

  validates :price, presence: {message: "は空欄では登録できません"} 
  validates :price, numericality:  {only_integer: true, greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999,message: "は指定範囲内で、半角数字でご入力ください"}, allow_blank: true


  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day
  has_one_attached :image, dependent: :destroy
  has_one :purchase, dependent: :destroy
end
