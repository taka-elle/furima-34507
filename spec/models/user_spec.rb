require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全て入力されていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailに＠が含まれていれば登録できる' do
        @user.email = 'aaa@aaa'
        expect(@user).to be_valid
      end
      it 'passowrdとpassword_confirmationが６文字以上であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが半角英数字混合していれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.last_name = '田中たなかタナカ'
        expect(@user).to be_valid
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.first_name = '太郎たろうタロウ'
        expect(@user).to be_valid
      end
      it 'last_name_fが全角（カタカナ）であれば登録できる' do
        @user.last_name_f = 'タナカ'
        expect(@user).to be_valid
      end
      it 'first_name_fが全角（カタカナ）であれば登録できる' do
        @user.first_name_f = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録されない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録されない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'passwordが空では登録されない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'passwordが存在してもpassword_confirmationが空では登録されない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it 'last_nameが空では登録されない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字を入力してください"
      end
      it 'first_nameが空では登録されない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end
      it 'last_name_fが空では登録されない' do
        @user.last_name_f = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字（カナ）を入力してください"
      end
      it 'first_name_fが空では登録されない' do
        @user.first_name_f = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前（カナ）を入力してください"
      end
      it 'birthdayに選択されていないところがあれば登録されない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
      it '既に登録されているemailでは登録されない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end
      it '＠を含んでいないemailは登録されない' do
        @user.email = 'testcom'
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end
      it 'passwordは５文字以下では登録されない' do
        @user.password = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end
      it 'passwordとpassword_confirmationが異なる場合は登録されない' do
        @user.password = 'a00000'
        @user.password_confirmation = 'a11111'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it 'passwordとpassword_confirmationが半角数字だけでは登録されない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end
      it 'passwordとpassword_confirmationが半角英字だけでは登録されない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外の場合、登録されない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include "名字は全角で入力してください"
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外の場合、登録されない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は全角で入力してください"
      end
      it 'last_name_fが全角（カタカナ）以外の場合、登録されない' do
        @user.last_name_f = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include "名字（カナ）は全角カタカナで入力してください"
      end
      it 'first_name_fが全角（カタカナ）以外の場合、登録されない' do
        @user.first_name_f = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前（カナ）は全角カタカナで入力してください"
      end
    end
  end
end
