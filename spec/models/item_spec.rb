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
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "画像を入力してください"
      end
      it 'nameが空だと保存されない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it 'textがからだと保存されない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "説明文を入力してください"
      end
      it 'category_idが１だと保存されない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーを選択してください"
      end
      it 'status_idが１だと保存されない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "ステータスを選択してください"
      end
      it 'charges_idが１だと保存されない' do
        @item.charges_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担を選択してください"
      end
      it 'area_idが１だと保存されない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "地域を選択してください"
      end
      it 'day_idが１だと保存されない' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "日数を選択してください"
      end
      it 'priceが空だと保存されない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "値段を入力してください"
      end
      it 'priceの値が299以下だと保存されない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は299より大きい値にしてください"
      end
      it 'priceの値が10000000以上だと保存されない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は10000000より小さい値にしてください"
      end
      it 'ユーザーが紐づいていなければ保存されない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Userを入力してください"
      end
      it 'priceが全角文字では保存されない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は数値で入力してください"
      end
      it 'priceが半角英数混合では登録できないこと' do
        @item.price = 'a1234'
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は数値で入力してください"
      end
      it 'priceが半角英語だけでは登録できないこと' do
        @item.price = 'abcdef'
        @item.valid?
        expect(@item.errors.full_messages).to include "値段は数値で入力してください"
      end
    end
  end
end
