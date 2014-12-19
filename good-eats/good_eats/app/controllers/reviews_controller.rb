class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to "/restaurants/#{@review.restaurant_id}"
    else
      @restaurant = Restaurant.find(params[:restaurant_id])
      render action: "/new"
    end
  end

  private
  def review_params
    params.require(:review).permit(:review_text, :restaurant_id)
  end
end
