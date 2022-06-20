class Formob
  extend ActiveHash::Associations::ActiveRecordExtensions
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street_address, :building, :phone_number, :user_id, :item_id, :token

  validates :post_code, presence: true
  validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}, allow_blank: true
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
  validates :city, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true

  validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/, message: "is invalid. Input only number"}, allow_blank: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :token, presence:true


  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street_address: street_address, phone_number: phone_number, purchase_id: purchase.id)
  end

end