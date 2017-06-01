class Api::V1::RsdProductsController < ApiController

  def index
    rsd_products = RsdProduct.filter(params[:filter]).order("rsd ASC").page(params[:page]).per(params[:limit])

    render_with_meta_data rsd_products, rsd_products.total_pages
  end

  def never_product
    rsd_product = RsdProduct.find params[:id]
    rsd_product.toggle_never_product
    render json: rsd_product
  end

end
