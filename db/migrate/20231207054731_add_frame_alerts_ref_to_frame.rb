class AddFrameAlertsRefToFrame < ActiveRecord::Migration[6.1]
  def change
    add_reference :frames, :frame_alerts, null: false, foreign_key: true
  end
end
