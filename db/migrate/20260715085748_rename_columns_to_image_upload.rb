class RenameColumnsToImageUpload < ActiveRecord::Migration[7.1]
  def change
    # Rename article column from image to image_upload
    if column_exists?(:articles, :image)
      rename_column :articles, :image, :image_upload
    end

    # Rename user column from avatar to image_upload
    if column_exists?(:users, :avatar)
      rename_column :users, :avatar, :image_upload
    end
  end
end
