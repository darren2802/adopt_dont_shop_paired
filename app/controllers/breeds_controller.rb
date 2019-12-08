class BreedsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @breeds = Pet.all.distinct.order(:breed).pluck(:breed)
    @breeds_pluralized = @breeds.map do |breed|
      breed.pluralize(2)
    end
  end
end
