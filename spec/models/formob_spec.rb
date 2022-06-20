require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @formob = FactoryBot.build(:formob, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば購入できること' do
      expect(@formob).to be_valid
    end
    it 'buildingは空でも購入できること' do
      @formob.building = ""
      expect(@formob).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'post_codeが空だと保存できないこと' do
      @formob.post_code = ""
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Post code can't be blank")
    end
    it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @formob.post_code = "0000000"
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it 'prefectureを選択していないと保存できないこと' do
      @formob.prefecture_id = 1
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'cityが空だと保存できないこと' do
      @formob.city = ""
      @formob.valid?
      expect(@formob.errors.full_messages).to include("City can't be blank")
    end
    it 'street_addressが空だと保存できないこと' do
      @formob.street_address = ""
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Street address can't be blank")
    end
    it 'phone_numberが空だと保存できないこと' do
      @formob.phone_number = ""
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberに"-"が含まれていると保存できないこと' do
      @formob.phone_number = "000-0000-0000"
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it 'phone_numberが9桁だと保存できないこと' do
      @formob.phone_number = "000000000"
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it 'phone_numberが12桁だと保存できないこと' do
      @formob.phone_number = "000000000000"
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Phone number is invalid. Input only number")
    end
    it 'itemが紐付いていないと保存できないこと' do
      @formob.item_id = nil
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Item can't be blank")
    end
    it 'userが紐付いていないと保存できないこと' do
      @formob.user_id = nil
      @formob.valid?
      expect(@formob.errors.full_messages).to include("User can't be blank")
    end
    it "tokenが空では登録できないこと" do
      @formob.token = nil
      @formob.valid?
      expect(@formob.errors.full_messages).to include("Token can't be blank")
    end
  end
end
