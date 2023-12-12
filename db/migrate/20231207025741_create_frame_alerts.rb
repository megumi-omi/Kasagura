class CreateFrameAlerts < ActiveRecord::Migration[6.1]
  def change
    create_table :frame_alerts do |t|
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
