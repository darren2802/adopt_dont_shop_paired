class AddApplicationApprovedToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :application_approved, :boolean, default:false
  end
end
