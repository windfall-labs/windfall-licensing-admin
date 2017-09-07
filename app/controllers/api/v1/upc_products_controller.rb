class Api::V1::UpcProductsController < ApiController

  def index
    upc_products = UpcProduct.search_v2(product_params)
    # upc_products = UpcProduct.where(alt_product_accepted_count: 1).page(params[:page]).per(params[:limit])
    render_with_meta_data upc_products, upc_products.total_pages
  end

  def update_field
    upc_product = UpcProduct.find params[:id]
    upc_product.toggle_field(params[:field])
    render json: upc_product
  end

  private
  def product_params
    params.permit(
      :accepted_count,
      :alt_product,
      :alt_product_accepted_count,
      :banner_id,
      :filter,
      :is_product,
      :limit,
      :never_product,
      :page,
      :receipt_accepted_count,
      :receipt_rejected_count,
      :rejected_count,
      :unique_accepted_count,
      :unique_rejected_count,
      :wrong_product,
      :sort,
      :dir
    )
  end
end
