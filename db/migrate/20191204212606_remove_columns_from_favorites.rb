class RemoveColumnsFromFavorites < ActiveRecord::Migration[5.1]
  def change
    remove_column :favorites, :name, :string
    remove_column :favorites, :image, :string
    remove_column :favorites, :age_approx, :integer
    remove_column :favorites, :sex, :string
    remove_column :favorites, :shelter_id, :integer
  end
end
