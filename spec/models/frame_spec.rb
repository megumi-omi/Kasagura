require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe '傘骨新規登録バリデーションのテスト' do
    before do
      @frame_alert = FrameAlert.create!(quantity: 10)
    end
    context '名前が空の場合' do
      it 'バリデーションに引っかかる' do
        frame = Frame.new(name: '', kind: 'frame_kind01', inventory: 10, frame_alert_id: @frame_alert.id)
        expect(frame).to be_invalid
      end
    end
    context '種類が空の場合' do
      it 'バリデーションに引っかかる' do
        frame = Frame.new(name: 'frame_name01', kind: '', inventory: 10, frame_alert_id: @frame_alert.id)
        expect(frame).to be_invalid
      end
    end
    context '在庫数が空の場合' do
      it 'バリデーションに引っかかる' do
        frame = Frame.new(name: 'frame_name01', kind: 'frame_kind01', inventory: '', frame_alert_id: @frame_alert.id)
        expect(frame).to be_invalid
      end
    end
  end
end
