class AddFavoritesToFavorites2 < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :book_id, :integer
  end
end
