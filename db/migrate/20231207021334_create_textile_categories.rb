class CreateTextileCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :textile_categories do |t|
      t.string :name, limit: 50, null:false, unique: true

      t.timestamps
    end
  end
end
