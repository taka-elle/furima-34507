require 'rails_helper'

RSpec.describe ManagementAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    @management_address = FactoryBot.build(:management_address, user_id: item.user_id, item_id: item.id)
    sleep(0.1)
  end
  
  describe '購入者情報の保存' do
    context '購入者情報を保存できるとき' do
      it '全て入力されていれば保存される' do
        expect(@management_address).to be_valid
      end
      it 'add_buildが空でも保存される' do
        @management_address.add_build = ""
        expect(@management_address).to be_valid
      end
      it 'tel_numが11文字以下であれば保存される' do
        @management_address.tel_num = "12345678901"
        expect(@management_address).to be_valid
      end
    end

    context '購入者情報を保存できないとき' do
      it 'add_numが空の場合保存されない' do
        @management_address.add_num = ""
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Add num can't be blank", "Add num is invalid. Include hyphen(-)"
      end
      it 'add_numに「-」ハイフンがない場合保存されない' do
        @management_address.add_num = "0000000"
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Add num is invalid. Include hyphen(-)"
      end
      it 'add_numがハイフンがあっても数字でなければ保存されない' do
        @management_address.add_num = "abc-defg"
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Add num is invalid. Include hyphen(-)"
      end
      it 'area_idが1だと保存されない' do
        @management_address.area_id = 1
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include 'Area must be other than 1'
      end
      it 'cityが空の場合保存されない' do
        @management_address.city = ""
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "City can't be blank"
      end
      it 'add_lineが空の場合保存されない' do
        @management_address.add_line = ""
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Add line can't be blank"
      end
      it 'tel_numが空の場合保存されない' do
        @management_address.tel_num = ""
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Tel num can't be blank"
      end
      it 'tel_numが11文字以上の場合保存されない' do
        @management_address.tel_num = "123456789012"
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Tel num is too long (maximum is 11 characters)"
      end
      it 'tel_numが数値以外の場合保存されない' do
        @management_address.tel_num = "abcdefg"
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Tel num is invalid"
      end
      it 'tokenが空の場合保存されない' do
        @management_address.token = nil
        @management_address.valid?
        expect(@management_address.errors.full_messages).to include "Token can't be blank"
      end
    end
  end
end
