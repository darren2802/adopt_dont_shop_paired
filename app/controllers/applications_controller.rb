class ApplicationsController < ApplicationController
  def new
    @pet_favorites = populate_pet_favorites
  end

  def create
    pets_applied_for = []
    params.each do |key,value|
      if key[0..8] == 'checkbox-'
        pets_applied_for << key[9..11]
      end
    end

    new_app = Application.create(application_params)

    if new_app.save
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
    pet_favorites = Hash.new()
    favorite.contents.each_key do |key|
      pet_favorites[key] = Hash.new()
      pet_favorites[key]['name'] = Pet.find(key).name
    end
    pet_favorites
  end


  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone, :motivation)
    end

end
