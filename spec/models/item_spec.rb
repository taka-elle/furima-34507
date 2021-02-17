require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品する商品の保存' do
    context '商品が保存されるとき' do
      it '全て入力されていれば保存される' do
        expect(@item).to be_valid
      end
    end

    context '商品が保存されないとき' do
      it 'imageが空だと保存されない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'nameが空だと保存されない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it 'textがからだと保存されない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Text can't be blank"
      end
      it 'category_idが１だと保存されない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Category must be other than 1'
      end
      it 'status_idが１だと保存されない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Status must be other than 1'
      end
      it 'charges_idが１だと保存されない' do
        @item.charges_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Charges must be other than 1'
      end
      it 'area_idが１だと保存されない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Area must be other than 1'
      end
      it 'day_idが１だと保存されない' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'Day must be other than 1'
      end
      it 'priceが空だと保存されない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceの値が299以下だと保存されない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be greater than 299'
      end
      it 'priceの値が10000000以上だと保存されない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price must be less than 10000000'
      end
      it 'ユーザーが紐づいていなければ保存されない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'User must exist'
      end
      it 'priceが全角文字では保存されない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it 'priceが半角英数混合では登録できないこと' do
        @item.price = 'a1234'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
      it 'priceが半角英語だけでは登録できないこと' do
        @item.price = 'abcdef'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is not a number'
      end
    end
  end
end
