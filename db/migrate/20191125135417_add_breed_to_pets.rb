class AddBreedToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :breed, :string
  end
end
