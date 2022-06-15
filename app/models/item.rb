class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :image, presence: { message: 'must be attached' }
  validates :name, presence: { message: "can't be blank"} 
  validates :explanation, presence: { message: "can't be blank"}

  validates :category_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :delivery_charge_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}

  validates :price, presence: {message: "can't be blank"} 
  validates :price, numericality:  {greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999,message: "must be half-width characters in setting range"}, allow_blank: true


  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day
  has_one_attached :image, dependent: :destroy
end
