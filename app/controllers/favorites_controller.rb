class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.All
  end

  def favorites_count
    
  end


end
