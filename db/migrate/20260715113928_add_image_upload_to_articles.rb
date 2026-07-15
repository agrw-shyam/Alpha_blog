class AddImageUploadToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :image_upload, :string
  end
end
