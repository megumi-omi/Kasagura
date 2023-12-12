class RenameTextileCategoryIdColumnToProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :textile_category_id, :category_id
  end
end
