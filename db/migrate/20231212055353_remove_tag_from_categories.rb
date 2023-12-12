class RemoveTagFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :tag, :string
  end
end
