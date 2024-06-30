require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    # ユーザー新規登録についてのテストコードを記述します  
    it 'nicknameが空では登録できない' do
      # nicknameが空では登録できないテストコードを記述します
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      # emailが空では登録できないテストコードを記述します
      user = User.new(nickname: 'test', email: '', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      # passwordが空では登録できないテストコードを記述します
      user = User.new(nickname: 'test', email: 'test@test', password: '', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'password_confirmationが空では登録できない' do
      # password_confirmationが空では登録できないテストコードを記述します
      user = User.new(nickname: 'test', email: 'test@test', password: '000000', password_confirmation: '')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'lastnameが空では登録できない' do
      # lastnameが空では登録できないテストコードを記述します
      user = User.new(nickname: 'test', email: 'test@test', password: '000000', password_confirmation: '000000', lastname: '')
      user.valid?
      expect(user.errors.full_messages).to include("Lastname can't be blank")
    end
    it 'firstnameが空では登録できない' do
      # firstnameが空では登録できないテストコードを記述します
      user = User.new(nickname: 'test', email: 'test@test', password: '000000', password_confirmation: '000000', lastname: 'test', firstname: '')
      user.valid?
      expect(user.errors.full_messages).to include("Firstname can't be blank")
    end
  end
end
