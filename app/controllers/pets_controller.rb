class PetsController < ApplicationController
  def index
    @pets = Pet.order('RANDOM()').limit(100)
  end

  def show
    @pet = Pet.find(params[:id])

    @favorited = false
    if favorite.contents.has_key?(params[:id])
      @favorited = true
    else
      @favorited = false
    end

  end

  def new
    @shelter_id = params[:id]
  end

  def create
    modified_params = pet_params
    shelter = Shelter.find(modified_params[:shelter_id])
    pet = shelter.pets.create(modified_params)
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    pet.destroy

    redirect_to '/pets'
  end

  def approve_application
    modified_params = pet_params
    modified_params[:application_approved] = true
    pet = Pet.find(params[:id])
    pet.update(modified_params)

    redirect_to "/pets/#{params[:id]}"
  end

  private
    def pet_params
      params.permit(:name, :image, :description, :age_approx, :sex, :breed, :shelter_id)
    end

end
