class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
  end

   def favoritedpet
     Favorite.create(pet_id: params[:id])

     pet_name = Pet.find(params[:id]).name

     flash[:notice] = "#{pet_name} has been added to Favorites"
     redirect_to "/pets/#{params[:id]}"
   end
end
