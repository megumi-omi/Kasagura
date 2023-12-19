require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe '傘骨新規登録バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションに引っかかる' do
      end
    end
    context '種類が空の場合' do
      it 'バリデーションに引っかかる' do
      end
    end
    context '在庫数が空の場合' do
      it 'バリデーションに引っかかる' do
      end
    end
    context '名前が51文字以上の場合' do
      it 'バリデーションに引っかかる' do
      end
    end
  end
end
