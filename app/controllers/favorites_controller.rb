class FavoritesController < ApplicationController
  def index
    @pet_favorites = Hash.new()

    favorite.contents.each_key do |key|
      @pet_favorites[key] = Hash.new()
      @pet_favorites[key]['name'] = Pet.find(key).name
      @pet_favorites[key]['image'] = Pet.find(key).image
    end
    @pet_favorites
  end

   def favoritedpet
     pet_name = Pet.find(params[:pet_id]).name
     pet_id_str = params[:pet_id].to_s

     @favorite = Favorite.new(session[:favorite])

     @favorite.add_pet(pet_id_str)

     session[:favorite] = @favorite.contents


     flash[:notice] = "#{pet_name} has been added to Favorites"
     redirect_to "/pets/#{params[:pet_id]}"
   end
end
