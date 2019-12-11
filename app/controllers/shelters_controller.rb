class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def create
    Shelter.create(shelter_params)
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)

    redirect_to '/shelters'
  end

  def destroy
    shelter = Shelter.find(params[:id])

    if PetApplication.joins(:pet).where('pet_applications.application_approved = true and pets.shelter_id = ?', params[:id]).count == 0
      shelter.destroy
      flash[:notice] = "#{shelter.name} has been deleted."
    else
      flash[:notice] = "#{shelter.name} cannot be deleted as it has pets with approved applications (status pending). Please revoke the applications first."
    end

    redirect_to '/shelters'
  end

  def showpets
    @shelter_pets = Pet.where("shelter_id = ?", params[:id]).order(breed: :asc, name: :asc)
    @pet_count = @shelter_pets.count
    @shelter_name = Shelter.find(params[:id]).name
    @shelter_id = params[:id]
  end

  private

    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
