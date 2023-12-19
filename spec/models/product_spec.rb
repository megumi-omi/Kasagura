require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '新規登録バリデーションのテスト' do
    before do
      # admin_user,category,frame,frame_alert,tag,product_alert
      admin_user = 
      categories = 
    end
    
    context '商品名が空の場合' do
      it 'バリデーションに引っかかる' do
        product = Product.new(name: '', stock: '')
      end
    end
    context '商品の在庫数が空の場合' do
      it 'バリデーションに引っかかる' do
      end
    end
  end

  describe '在庫検索機能のテスト' do
    context 'カテゴリで検索した場合' do
      it '全商品の中から、選択したカテゴリに一致した商品が表示される' do
      end
    end
    context '種類で選択した場合' do
      it '全商品の中から、選択した種類に一致した商品が表示される' do
      end
    end
    context '在庫なしで選択した場合' do
      it '全商品の中から、在庫0の商品が表示される' do
      end
    end
    context '種類で選択した場合' do
      it '全商品の中から、選択したタグに一致した商品が表示される' do
      end
    end
  end

  describe '在庫追加機能のテスト' do
  end

  describe 'アラート表示機能のテスト' do
  end
end