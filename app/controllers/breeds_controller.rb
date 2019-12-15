class BreedsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @breeds = Pet.all.distinct.order(:breed).pluck(:breed)
    @breeds_pluralized = @breeds.map do |breed|
      breed.pluralize(2)
    end
  end

  def show
    breed = ''
    if params[:breed_name] == 'border_collies'
      # singularize below changes border_collies to Border Colly not Border Collie
      breed = 'Border Collie'
    else
      breed = params[:breed_name].gsub('_',' ').singularize.titleize
    end
    @pets = Pet.where("breed LIKE ?", "%#{breed}%")
  end
end
