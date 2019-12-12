class RemoveApplicationApprovedFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :application_approved, :boolean
  end
end
