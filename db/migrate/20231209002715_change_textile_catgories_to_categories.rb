class ChangeTextileCatgoriesToCategories < ActiveRecord::Migration[6.1]
  def change
    rename_table :textile_categories, :categories
    add_column :categories, :tag, :string, limit: 50
  end
end
