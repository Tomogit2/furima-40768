require 'rails_helper'
require 'faker'

RSpec.describe ShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    puts @user.id

    @item = FactoryBot.create(:item, user: @user)
    @purchase = FactoryBot.create(:purchase, user: @user, item: @item)
    @shipping_address = FactoryBot.build(:shipping_address, purchase: @purchase)
  end

  describe '商品購入機能' do
    context '商品購入ができるとき' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@shipping_address).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it "郵便番号が空では登録できないこと" do
        @shipping_address.zip_code = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Zip code can't be blank")  
      end

      it "都道府県が空では登録できないこと" do
        @shipping_address.prefecture_id = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Prefecture can't be blank")      
      end  

      it "市区町村が空では登録できないこと" do
        @shipping_address.municipalities = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Municipalities can't be blank")      
      end  

      it "番地が空では登録できないこと" do
        @shipping_address.street_address = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Street address can't be blank")      
      end  

      it "電話番号が空では登録できないこと" do
        @shipping_address.telephone_number = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Telephone number can't be blank")      
      end            
    end
  end
end
      