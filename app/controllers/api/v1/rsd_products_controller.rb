class Api::V1::RsdProductsController < ApiController

  def index
    rsd_products = RsdProduct.filter(
                                      params[:filter],
                                      params[:receipt_accepted_count],
                                      params[:unique_rejected_count],
                                      params[:unique_accepted_count],
                                      params[:accepted_count],
                                      params[:rejected_count],
                                      params[:alt_product_accepted_count],
                                      params[:alt_product],
                                      params[:receipt_rejected_count]
                                    ).order("rsd ASC")
                                     .page(params[:page])
                                     .per(params[:limit])
    # rsd_products = RsdProduct.where(alt_product_accepted_count: 1).page(params[:page]).per(params[:limit])
    render_with_meta_data rsd_products, rsd_products.total_pages
  end

  def update_field
    rsd_product = RsdProduct.find params[:id]
    rsd_product.toggle_field(params[:field])
    render json: rsd_product
  end

  # def sort
  #   if params[:sort].present? && params[:dir].present?
  #     "#{params[:sort] params[:dir]}"
  #   else
  #     "rsd ASC"
  #   end
  # end
end
