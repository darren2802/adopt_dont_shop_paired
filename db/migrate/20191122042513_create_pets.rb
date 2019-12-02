class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :image
      t.integer :age_approx
      t.string :sex
      t.integer :shelter_id

      t.timestamps
    end
  end
end
