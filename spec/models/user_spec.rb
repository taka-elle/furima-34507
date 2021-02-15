require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できるとき" do
      it "全て入力されていれば登録できる" do
        expect(@user).to be_valid
      end
      it "emailに＠が含まれていれば登録できる" do
        @user.email = 'aaa@aaa'
        expect(@user).to be_valid
      end
      it "passowrdとpassword_confirmationが６文字以上であれば登録できる" do
        @user.password = "a12345"
        @user.password_confirmation = "a12345"
        expect(@user).to be_valid
      end
      it "passwordとpassword_confirmationが半角英数字混合していれば登録できる" do
        @user.password = "a12345"
        @user.password_confirmation = "a12345"
        expect(@user).to be_valid
      end
      it "last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.last_name = "田中たなかタナカ"
        expect(@user).to be_valid
      end
      it "first_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.first_name = "太郎たろうタロウ"
        expect(@user).to be_valid
      end
      it "last_name_fが全角（カタカナ）であれば登録できる" do
        @user.last_name_f = "タナカ"
        expect(@user).to be_valid
      end
      it "first_name_fが全角（カタカナ）であれば登録できる" do
        @user.first_name_f = "タロウ"
        expect(@user).to be_valid
      end
    end

    context "新規登録できないとき" do
      it "nicknameが空では登録されない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it "emailが空では登録されない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "passwordが空では登録されない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "passwordが存在してもpassword_confirmationが空では登録されない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "last_nameが空では登録されない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it "first_nameが空では登録されない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it "last_name_fが空では登録されない" do
        @user.last_name_f = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name f can't be blank"
      end
      it "first_name_fが空では登録されない" do
        @user.first_name_f = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name f can't be blank"
      end
      it "birthdayに選択されていないところがあれば登録されない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
      it "既に登録されているemailでは登録されない" do
        @user.save
        another_user = FactoryBot.build(:user,email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it "＠を含んでいないemailは登録されない" do
        @user.email = "testcom"
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it "passwordは５文字以下では登録されない" do
        @user.password = "a1234"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it "passwordとpassword_confirmationが異なる場合は登録されない" do
        @user.password = "a00000"
        @user.password_confirmation = "a11111"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "passwordとpassword_confirmationが半角数字だけでは登録されない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "passwordとpassword_confirmationが半角英字だけでは登録されない" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "last_nameが全角（漢字・ひらがな・カタカナ）以外の場合、登録されない" do
        @user.last_name = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name Full-width characters."
      end
      it "first_nameが全角（漢字・ひらがな・カタカナ）以外の場合、登録されない" do
        @user.first_name = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name Full-width characters."
      end
      it "last_name_fが全角（カタカナ）以外の場合、登録されない" do
        @user.last_name_f = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name f Full-width katakana characters."
      end
      it "first_name_fが全角（カタカナ）以外の場合、登録されない" do
        @user.first_name_f = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name f Full-width katakana characters."
      end
    end
  end
end
