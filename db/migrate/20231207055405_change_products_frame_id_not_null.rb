class ChangeProductsFrameIdNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :products, :textile_categories_id, false
    change_column_null :products, :frames_id, false
    change_column_null :products, :product_alerts_id, false

  end
end
