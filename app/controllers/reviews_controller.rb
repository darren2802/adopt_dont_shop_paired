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

  def edit
    @review = Review.find(params[:id])
  end

  def update
    shelter_id = Review.find(params[:id]).shelter_id
    review = Review.find(params[:id])
    review.update(review_params)

    redirect_to "/shelters/#{shelter_id}"
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :image)
    end
end
