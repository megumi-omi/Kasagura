class RemoveColorFromFrames < ActiveRecord::Migration[6.1]
  def change
    remove_column :frames, :color, :string
  end
end
