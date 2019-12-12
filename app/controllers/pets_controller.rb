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
    @pet = Pet.find(params[:id])
    if PetApplication.where('pet_applications.application_approved = true and pet_applications.pet_id = ?', params[:id]).count > 0
      flash.now[:notice] = 'Pet has approved application and cannot be deleted.'
      render :show
    else
      @pet.destroy
      flash.now[:notice] = "#{@pet.name} (id: #{@pet.id}) has been deleted."
      redirect_to '/pets'
    end
  end

  def approve_application
    pet_app = PetApplication.where('pet_id = ?', params[:id])
    pet_app.update(application_approved: true)

    redirect_to "/pets/#{params[:id]}"
  end

  def revoke_application
    pet_app = PetApplication.where('pet_id = ?', params[:id])
    pet_app.update(application_approved: false)

    redirect_to "/pets/#{params[:id]}"
  end

  private
    def pet_params
      params.permit(:name, :image, :description, :age_approx, :sex, :breed, :shelter_id)
    end

end
