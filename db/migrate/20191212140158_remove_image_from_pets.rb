class RemoveImageFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :image, :string
  end
end
