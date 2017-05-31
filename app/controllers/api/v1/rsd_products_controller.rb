class Api::V1::RsdProductsController < ApiController

	def index
    rsd_products = RsdProduct.filter(params[:filter]).page(params[:page]).per(params[:limit])

    render_with_meta_data rsd_products, rsd_products.total_pages
	end

  # def preview_images
  #   next_images = RsdProduct.where("id > ?", params[:id]).first(5)
  #   prev_images = RsdProduct.where("id < ?", params[:id]).last(5)
  #
  #   render json: {prev_receipts: prev_images, next_images: next_images}
  # end

end
