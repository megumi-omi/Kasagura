class RenameFromTypeTokindOnFrames < ActiveRecord::Migration[6.1]
  def change
    rename_column :frames, :type, :kind
  end
end
