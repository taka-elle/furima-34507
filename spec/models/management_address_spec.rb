require 'rails_helper'

RSpec.describe ManagementAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @management_address = FactoryBot.build(:management_address, user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  describe '購入者情報の保存' do
    context '購入者情報を保存できるとき' do
      it '全て入力されていれば保存される' do
        expect(@management_address).to be_valid
      end
      it 'add_buildが空でも保存される' do
        @management_address.add_build = ''
        expect(@management_address).to be_valid
      end
      it 'tel_numが11文字以下であれば保存される' do
        @management_address.tel_num = '12345678901'
        expect(@management_address).to be_valid
      end
    end

    context '購入者情報を保存できないとき' do
      it 'add_numが空の場合保存されない' do
        @management_address.add_num = ''
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "郵便番号を入力してください"
      end
      it 'add_numに「-」ハイフンがない場合保存されない' do
        @management_address.add_num = '0000000'
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "郵便番号はハイフン(-)を入れてください"
      end
      it 'add_numがハイフンがあっても数字でなければ保存されない' do
        @management_address.add_num = 'abc-defg'
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "郵便番号はハイフン(-)を入れてください"
      end
      it 'area_idが1だと保存されない' do
        @management_address.area_id = 1
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "都道府県を選択してください"
      end
      it 'cityが空の場合保存されない' do
        @management_address.city = ''
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "市区町村を入力してください"
      end
      it 'add_lineが空の場合保存されない' do
        @management_address.add_line = ''
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "番地を入力してください"
      end
      it 'tel_numが空の場合保存されない' do
        @management_address.tel_num = ''
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "電話番号を入力してください"
      end
      it 'user_idがからの場合保存されない' do
        @management_address.user_id = ''
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Userを入力してください"
      end
      it 'item_idがからの場合保存されない' do
        @management_address.item_id = ''
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Itemを入力してください"
      end
      it 'tel_numが11文字以上の場合保存されない' do
        @management_address.tel_num = '123456789012'
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "電話番号は11文字以内で入力してください"
      end
      it 'tel_numが数値以外の場合保存されない' do
        @management_address.tel_num = 'abcdefg'
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "電話番号半角英数字で入力してください"
      end
      it 'tel_numが英数字混合では保存されない'do
        @management_address.tel_num = 'abcde12345'
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "電話番号半角英数字で入力してください"
      end
      it 'tokenが空の場合保存されない' do
        @management_address.token = nil
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "クレジットカード情報を入力してください"
      end
    end
  end
end
