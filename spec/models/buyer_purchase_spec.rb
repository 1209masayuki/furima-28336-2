require 'rails_helper'

RSpec.describe BuyerPurchase, type: :model do
  describe '購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.build(:item, user_id: user.id)
      item.image = fixture_file_upload('/IMG_5140.jpg', 'image/jpg')
      item.save
      @buyer_purchase = FactoryBot.build(:buyer_purchase, user_id: user.id, item_id: item.id)
    end
    context '購入ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@buyer_purchase).to be_valid
      end
      it '電話番号10桁で登録できる' do
        @buyer_purchase.phone_num = "0901234567"
        expect(@buyer_purchase).to be_valid
      end
      it '電話番号11桁で登録できる' do
        @buyer_purchase.phone_num = "09012345678"
        expect(@buyer_purchase).to be_valid
      end
      it '建物名は空でも保存できること' do
        @buyer_purchase.building = nil
        expect(@buyer_purchase).to be_valid
      end
    end
    context '購入ができないとき' do
      it '郵便番号が空だと保存できないこと' do
        @buyer_purchase.postal_code = nil
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buyer_purchase.postal_code = '1234567'
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県を選択していないと保存できないこと' do
        @buyer_purchase.prefecture_id = 1
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市町村が空だと保存できないこと' do
        @buyer_purchase.city = nil
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @buyer_purchase.addresses = nil
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @buyer_purchase.phone_num = nil
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Phone num can't be blank")
      end
      it '電話番号が12桁以上だと登録できない' do
        @buyer_purchase.phone_num = "090123456789"
        @buyer_purchase.valid?

        expect(@buyer_purchase.errors.full_messages).to include("Phone num is out of setting range")
      end
      it '電話番号が9桁以下だと登録できない' do
        @buyer_purchase.phone_num = "090123456"
        @buyer_purchase.valid?
        expect(@buyer_purchase.errors.full_messages).to include("Phone num is out of setting range")
      end
    end
  end
end
