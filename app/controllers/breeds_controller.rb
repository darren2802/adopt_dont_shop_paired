class BreedsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    breeds = Pet.order(:breed).distinct.pluck(:breed)
    @breeds_pluralized = breeds.map { |breed| pluralize(breed) }
  end
end
