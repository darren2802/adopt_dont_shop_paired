class AddApplicationApprovedToPetApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_applications, :application_approved, :boolean, default:false
  end
end
