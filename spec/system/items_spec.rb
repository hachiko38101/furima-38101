require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @item = FactoryBot.create(:item)
  end

  context '出品に成功したとき' do
    it '出品に成功すると、トップページに遷移される' do
      sign_in(@item.user)
      expect(page).to have_content('出品する')
      visit new_item_path
      image_path = Rails.root.join('public/images/test_image.png') 
      attach_file('item[image]', image_path, make_visible: true)
      fill_in "item-name", with: @item.name
      fill_in "item-info", with: @item.explanation
      select @item.condition.name, from: "item[condition_id]"
      select @item.delivery_charge.name, from: "item[delivery_charge_id]"
      select @item.prefecture.name, from: "item[prefecture_id]"
      select @item.shipping_day.name, from: "item[shipping_day_id]"
      select @item.category.name, from: "item[category_id]"
      fill_in "item-price", with: @item.price
      add_tax_price = @item.price * 0.1
      profit = @item.price -add_tax_price
      expect(page).to have_content(profit.floor)
      expect(page).to have_content(add_tax_price.floor)
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      expect(current_path).to eq(root_path)
    end
  end

  context '投稿に失敗したとき' do
    it '商品の投稿に不備があると、商品出品ページに戻される' do
      sign_in(@item.user)
      expect(page).to have_content('出品する')
      visit new_item_path      
      fill_in "item-name", with: ""
      fill_in "item-info", with: ""
      fill_in "item-price", with: ""
      select "---", from: "item[condition_id]"
      select "---", from: "item[delivery_charge_id]"
      select "---", from: "item[prefecture_id]"
      select "---", from: "item[shipping_day_id]"
      select "---", from: "item[category_id]"
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)
      expect(current_path).to eq(items_path)
    end
  end
end
