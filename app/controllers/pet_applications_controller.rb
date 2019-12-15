class PetApplicationsController < ApplicationController
  def update
    pet_app = PetApplication.where('application_id = ? and pet_id = ?', params[:app_id], params[:pet_id])
    pet_app.update(application_approved: true)

    redirect_to "/pets/#{params[:pet_id]}"
  end

  def revoke
    pet_app = PetApplication.where('pet_id = ?', params[:pet_id])
    pet_app.update(application_approved: false)

    redirect_to "/pets/#{params[:pet_id]}"
  end
end
