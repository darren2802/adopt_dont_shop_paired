class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.new(review_params)
    @shelter_id = shelter.id

    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = 'Incomplete review submitted, please try again.'
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    shelter_id = Review.find(params[:id]).shelter_id
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to "/shelters/#{shelter_id}"
    else
      flash.now[:notice] = 'Incomplete information, please try again.'
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    shelter_id = review.shelter_id
    review.destroy

    redirect_to "/shelters/#{shelter_id}"
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :image)
    end
end
