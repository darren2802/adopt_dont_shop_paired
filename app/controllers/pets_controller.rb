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

    if pet.save
      flash[:notice] = "#{pet.name} (id: #{pet.id}) was added successfully."
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:notice] = 'Pet not added due to incomplete information, please try again.'
      render :new
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)

    if @pet.save
      flash[:notice] = "#{@pet.name} (id: #{@pet.id}) was updated successfully."
      redirect_to "/pets/#{@pet.id}"
    else
      flash[:notice] = 'Pet not updated due to incomplete information, please try again.'
      render :edit
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    if PetApplication.where('pet_applications.application_approved = true and pet_applications.pet_id = ?', params[:id]).count > 0
      flash.now[:notice] = "#{@pet.name} has an approved application and cannot be deleted."
      render :show
    else
      @pet.destroy
      pet_id_str = params[:id].to_s
      @favorite = Favorite.new(session[:favorite])
      @favorite.delete_pet(pet_id_str)
      flash.now[:notice] = "#{@pet.name} (id: #{@pet.id}) has been deleted."
      redirect_to '/pets'
    end
  end

  private
    def pet_params
      params.permit(:name, :image, :description, :age_approx, :sex, :breed, :shelter_id)
    end

end
