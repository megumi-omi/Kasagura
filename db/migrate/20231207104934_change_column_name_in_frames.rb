class ChangeColumnNameInFrames < ActiveRecord::Migration[6.1]
  def change
    rename_column :frames, :frame_alerts_id, :frame_alert_id
  end
end
