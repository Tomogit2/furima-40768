require 'rails_helper'
require 'faker'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品購入ができるとき' do
      it '全ての値が正しく入力されていれば（tokenがあれば）購入できる' do
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end

    context '商品購入ができるとき' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it '郵便番号が空では登録できないこと' do
        @purchase_address.zip_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Zip code can't be blank")
      end

      it '都道府県が空では登録できないこと' do
        @purchase_address.prefecture_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では登録できないこと' do
        @purchase_address.municipalities = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '番地が空では登録できないこと' do
        @purchase_address.street_address = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空では登録できないこと' do
        @purchase_address.telephone_number = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number can't be blank")
      end
    end
  end
end
