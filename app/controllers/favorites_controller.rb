class FavoritesController < ApplicationController
  def index
    @pet_favorites = Hash.new()

    favorite.contents.each_key do |key|
      @pet_favorites[key] = Hash.new()
      @pet_favorites[key]['name'] = Pet.find(key).name
      @pet_favorites[key]['image'] = Pet.find(key).image
    end
    @pet_favorites

    pet_ids = PetApplication.all.distinct.pluck(:pet_id)
    @pets_applied_for = Hash.new()
    pet_ids.each do |pet_id|
      @pets_applied_for[pet_id] = Pet.find(pet_id).name
    end
    @pets_applied_for
  end

   def add_favorite
     pet_name = Pet.find(params[:pet_id]).name
     pet_id_str = params[:pet_id].to_s

     @favorite = Favorite.new(session[:favorite])
     @favorite.add_pet(pet_id_str)
     session[:favorite] = @favorite.contents

     flash[:notice] = "#{pet_name} has been added to Favorites"
     redirect_to "/pets/#{params[:pet_id]}"
   end

   def destroy
     pet_name = Pet.find(params[:pet_id]).name
     pet_id_str = params[:pet_id].to_s
     @favorite = Favorite.new(session[:favorite])
     @favorite.delete_pet(pet_id_str)

     flash[:notice] = "#{pet_name} has been removed from Favorites"
     redirect_to "/pets/#{params[:pet_id]}"
   end

   def destroy_from_index
     pet_name = Pet.find(params[:pet_id]).name
     pet_id_str = params[:pet_id].to_s
     @favorite = Favorite.new(session[:favorite])
     @favorite.delete_pet(pet_id_str)

     flash[:notice] = "#{pet_name} has been removed from Favorites"
     redirect_to "/favorites"
   end

   def destroy_all
     @favorite = Favorite.new(session[:favorite])
     @favorite.destroy_all
     redirect_to "/favorites"
   end
end
