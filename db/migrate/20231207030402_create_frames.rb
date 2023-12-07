class CreateFrames < ActiveRecord::Migration[6.1]
  def change
    create_table :frames do |t|
      t.string :name, limit: 50, null: false
      t.string :color, limit: 50, null: false
      t.string :type, limit: 50, null: false
      t.integer :inventory, null: false
      
      t.timestamps
    end
  end
end
