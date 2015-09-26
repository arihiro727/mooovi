class Product < ActiveRecord::Base
  has_many :reviews

  def rate_average
    reviews.average(:rate).round if reviews.present?
  end
end
