require 'rails_helper'
require 'faker'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品ができるとき' do
      it '全ての値が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it '画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'タイトルが空では出品できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it '説明が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが初期値(---)のままでは出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が初期値(---)のままでは出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '配送料の負担が初期値(---)のままでは出品できない' do
        @item.shipping_fee_bearer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee bearer can't be blank")
      end

      it '発送元の地域が初期値(---)のままでは出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が初期値(---)のままでは出品できない' do
        @item.shipping_delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping delivery time can't be blank")
      end

      it '販売価格が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '半角数字以外の値が含まれている場合は保存できない' do
        @item.price = '300abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '10000000以上の値では保存できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '販売価格が300未満では出品できない' do
        @item.price = Faker::Number.between(from: 0, to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '出品者が存在しないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
