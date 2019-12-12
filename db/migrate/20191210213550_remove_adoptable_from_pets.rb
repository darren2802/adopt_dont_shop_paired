class RemoveAdoptableFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :adoptable, :boolean
  end
end
