class ApplicationsController < ApplicationController
  def new
    @pet_favorites = populate_pet_favorites
  end

  def create
    pets_applied_for = params[:pets_selected]

    new_app = Application.create(application_params)
    if new_app.save && pets_applied_for
      flash[:notice] = 'Thank you for applying to adopt'
      @favorite = Favorite.new(session[:favorite])
      pets_applied_for.each do |pet_id|
        new_app.pets << Pet.find(pet_id)
        @favorite.delete_pet(pet_id)
      end
      redirect_to '/favorites'
    else
      flash[:notice] = 'Form incomplete please try again'
      @pet_favorites = populate_pet_favorites
      render :new
    end
  end

  def populate_pet_favorites
    @favorite = Favorite.new(session[:favorite])
    @favorite.favorite_pets
  end

  def show
    @application = Application.find(params[:id])
    @pets_data = PetApplication.pets_data(params[:id])
  end

  def pet_index
    @apps = PetApplication.pet_index_apps(params[:id])
    flash[:notice] = 'This pet has no applications for adoption' if @apps.empty?
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone, :motivation, :approved)
    end

end
