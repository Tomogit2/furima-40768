require 'rails_helper'
require 'faker'

Faker::Config.locale = :ja

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    # ユーザー新規登録についてのテストコードを記述します
    context '新規登録できるとき' do
      it '全ての項目が適切に記入されていれば登録できること' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      describe 'nickname' do
        it 'nicknameが空では登録できない' do
          # nicknameが空では登録できないテストコードを記述します
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
      end

      describe 'email' do
        it 'emailが空では登録できない' do
          # emailが空では登録できないテストコードを記述します
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it '重複したemailが存在する場合は登録できない' do
          # 重複したemailが存在する場合は登録できないテストコードを記述します
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'emailは@を含まないと登録できない' do
          # emailは@を含まないと登録できないテストコードを記述します
          @user.email = 'testemail.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
      end

      describe 'password' do
        it 'passwordが空では登録できない' do
          # passwordが空では登録できないテストコードを記述します
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordとpassword_confirmationが一致していないと登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '654321'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'passwordは6文字以上でないと登録できない' do
          @user.password = '12345'
          @user.password_confirmation = '12345'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'passwordが129文字以上では登録できない' do
          @user.password = Faker::Internet.password(min_length: 129, max_length: 129)
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
        end
        it '英字のみのパスワードでは登録できない' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password 英字と数字の両方を含めて設定してください')
        end
        it '数字のみのパスワードでは登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password 英字と数字の両方を含めて設定してください')
        end
        it '全角文字を含むパスワードでは登録できない' do
          @user.password = 'ａｂｃ１２３'
          @user.password_confirmation = 'ａｂｃ１２３'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password 英字と数字の両方を含めて設定してください')
        end
      end

      describe 'password_confirmation' do
        it 'password_confirmationが空では登録できない' do
          # password_confirmationが空では登録できないテストコードを記述します
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end

      describe 'lastname' do
        it 'lastnameが空では登録できない' do
          # lastnameが空では登録できないテストコードを記述します
          @user.lastname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Lastname can't be blank")
        end
        it 'lastnameに半角文字が含まれていると登録できない' do
          @user.lastname = '山ﾀﾞ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Lastname 全角文字を使用してください')
        end
      end

      describe 'firstname' do
        it 'firstnameが空では登録できない' do
          # firstnameが空では登録できないテストコードを記述します
          @user.firstname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Firstname can't be blank")
        end
        it 'firstnameに半角文字が含まれていると登録できない' do
          @user.firstname = '太ﾛｳ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Firstname 全角文字を使用してください')
        end
      end

      describe 'lastname_kana' do
        it 'lastname_kanaが空では登録できない' do
          # lastname_kanaが空では登録できないテストコードを記述します
          @user.lastname_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
        end
        it 'lastname_kanaにカタカナ以外の文字が含まれていると登録できない' do
          @user.lastname_kana = 'やまだ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Lastname kana 全角カタカナを使用してください')
        end
      end

      describe 'firstname_kana' do
        it 'firstname_kanaが空では登録できない' do
          # firstname_kanaが空では登録できないテストコードを記述します
          @user.firstname_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
        end
        it 'firstname_kanaにカタカナ以外の文字が含まれていると登録できない' do
          @user.firstname_kana = 'たろう'
          @user.valid?
          expect(@user.errors.full_messages).to include('Firstname kana 全角カタカナを使用してください')
        end
      end

      describe 'birthday' do
        it 'birthdayが空では登録できない' do
          # birthdayが空では登録できないテストコードを記述します
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end
end
