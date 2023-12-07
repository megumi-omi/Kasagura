class CreateProductAlerts < ActiveRecord::Migration[6.1]
  def change
    create_table :product_alerts do |t|
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
