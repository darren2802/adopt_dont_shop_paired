class BreedsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @breeds = Pet.select(
      [
        :breed, Pet.arel_table[:image].maximum.as('image'), Arel.star.count.as('nr_pets')
      ]
    ).group(:breed).order(:breed)
  end

  def show
    breed = ''
    if params[:breed_name] == 'border_collies'
      # singularize below on line 17 changes border_collies to Border Colly not Border Collie
      breed = 'Border Collie'
    else
      breed = params[:breed_name].gsub('_',' ').singularize.titleize
    end
    @pets = Pet.where("breed LIKE ?", "%#{breed}%").order(:name)
  end
end
