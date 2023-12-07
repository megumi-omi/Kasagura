class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :image, null: false
      t.integer :stock, null: false
      t.references :textile_categories, foreign_key: true
      t.references :frames, foreign_key: true
      t.references :product_alerts, foreign_key: true

      t.timestamps
    end
  end
end
