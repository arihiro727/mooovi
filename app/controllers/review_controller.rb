class ReviewController < ApplicationController
  before_action :ranking
  layout 'review_site'

def ranking
  review_product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
  @ranking = review_product_ids .map{|product_id| Product.find(product_id)}
end

end
