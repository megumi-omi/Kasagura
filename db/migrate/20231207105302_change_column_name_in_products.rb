class ChangeColumnNameInProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :textile_categories_id, :textile_category_id
    rename_column :products, :frames_id, :frame_id
    rename_column :products, :product_alerts_id, :product_alert_id
  end
end
