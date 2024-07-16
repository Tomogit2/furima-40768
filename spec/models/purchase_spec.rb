require 'rails_helper'
require 'faker'

RSpec.describe Purchase, type: :model do
  before do
    @purchase = FactoryBot.build(:purchase)
  end

  describe '商品購入機能' do
    context '商品購入ができるとき' do
      it '全ての値が正しく入力されていれば（tokenがあれば）購入できる' do
        expect(@purchase).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it 'tokenが空では登録できないこと' do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
