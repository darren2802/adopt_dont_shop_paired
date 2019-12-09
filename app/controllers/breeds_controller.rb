class BreedsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @breeds = Pet.all.distinct.order(:breed).pluck(:breed)
    @breeds_pluralized = @breeds.map do |breed|
      breed.pluralize(2)
    end
  end

  def show
    breed = params[:breed_name].gsub('_',' ').singularize.titleize
    @pets = Pet.where("breed LIKE ?", "%#{breed}%")
  end
end
