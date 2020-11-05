class AddImgHeaderToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :img_header, :string
  end
end
