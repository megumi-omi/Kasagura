require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '新規登録バリデーションのテスト' do
    before do
      @frame_alert = FrameAlert.create!(quantity: 10)
      @frame = Frame.create!(name: 'frame_name01', kind: 'frame_kind01', inventory: '15', frame_alert_id: @frame_alert.id)
      @category = Category.create!(name:'category01')
      @product_alert = ProductAlert.create!(quantity: 5)
    end
    
    context '商品名が空の場合' do
      it 'バリデーションに引っかかる' do
        product = Product.new(name: '', stock: '10', category_id: @category.id, frame_id: @frame.id, product_alert_id: @product_alert.id)
        expect(product).to be_invalid
      end
    end
    context '商品の在庫数が空の場合' do
      it 'バリデーションに引っかかる' do
        product = Product.new(name: 'product01', stock: '', category_id: @category.id, frame_id: @frame.id, product_alert_id: @product_alert.id)
        expect(product).to be_invalid
      end
    end
  end
end