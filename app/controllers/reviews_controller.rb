class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    @product = Product.find(params['product_id'])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to :back
    else
      @reviews = @product.reviews.order(created_at: :desc)
      @overall_rating = @reviews.average(:rating)
      render 'products/show', id: params['product_id']
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to :back
  end

  private

    def review_params
      params.require(:review).permit(
        :description,
        :rating,
        :product_id
      )
    end
end
