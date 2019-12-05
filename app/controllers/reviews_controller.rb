class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.new(review_params)

    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = 'Incomplete review submitted, please try again.'
      #render :new
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :image)
    end
end
