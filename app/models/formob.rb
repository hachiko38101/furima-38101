class Formob
  extend ActiveHash::Associations::ActiveRecordExtensions
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street_address, :building, :phone_number, :user_id, :item_id, :token

  validates :post_code, presence: true
  validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "の入力が正しくありません (例 123-4567)"}, allow_blank: true
  validates :prefecture_id, numericality: {other_than: 1, message: "は空欄では登録できません"}
  validates :city, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true

  validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/, message: "は数字のみでご入力ください"}, allow_blank: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :token, presence:true


  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street_address: street_address, phone_number: phone_number, purchase_id: purchase.id)
  end

end