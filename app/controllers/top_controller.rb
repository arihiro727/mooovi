class TopController < ReviewController

before_action :authenticate_user!, only:[:search, :entry]
  def index
    @products = Product.all.limit(20).order('id ASC')
  end

  def search
    @products = Product.where('title Like(?)', "%#{params[:keyword]}%")
  end

  def entry
    @product = Product.find(params[:id])
  end

  def post
    Review.create(nickname:current_user.nickname, product_id:params[:id], rate:create_params[:rate], review:create_params[:review])
    redirect_to action: :index
  end

  private
  def create_params
  params.permit(:nickname, :product_id, :rate, :review)
  end
end
