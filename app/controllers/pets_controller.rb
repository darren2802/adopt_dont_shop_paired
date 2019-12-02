class PetsController < ApplicationController
  def index
    @pets = Pet.all.order(adoptable: :desc, breed: :asc, name: :asc)
  end

  def show
    @pet = Pet.find(params[:id])
    @adopt_status = ''
    @adopt_link = ''
    @adopt_route = ''
    if @pet.adoptable == true
      @adopt_status = 'Adoptable'
      @adopt_link = 'Change to Adoption Pending'
      @adopt_route = "/pets/#{@pet.id}/pending"
    else
      @adopt_status = 'Pending adoption'
      @adopt_link = 'Change to Adoptable'
      @adopt_route = "/pets/#{@pet.id}/adoptable"
    end
    @adopt_status
  end

  def new
    @shelter_id = params[:id]
  end

  def create
    modified_params = pet_params
    modified_params[:adoptable] = true
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

  def topending
    pet = Pet.find(params[:id])
    pet.adoptable = false
    pet.save

    redirect_to '/pets'
  end

  def toadoptable
    pet = Pet.find(params[:id])
    pet.adoptable = true
    pet.save

    redirect_to '/pets'
  end

  private
    def pet_params
      params.permit(:name, :image, :description, :age_approx, :sex, :breed, :shelter_id)
    end

end
