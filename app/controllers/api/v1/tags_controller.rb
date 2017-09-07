class Api::V1::TagsController < ApiController
  def index
    # rsd_products = RsdProduct.filter(
    #                                   params[:filter],
    #                                   params[:receipt_accepted_count],
    #                                   params[:unique_rejected_count],
    #                                   params[:unique_accepted_count],
    #                                   params[:accepted_count],
    #                                   params[:rejected_count],
    #                                   params[:alt_product_accepted_count],
    #                                   params[:alt_product],
    #                                   params[:receipt_rejected_count],
    #                                   params[:banner_id],
    #                                   params[:is_product],
    #                                   params[:never_product],
    #                                   params[:wrong_product]
    #                                 ).order(sort)
    #                                  .page(params[:page])
    #                                  .per(params[:limit])
    # rsd_products = RsdProduct.where(alt_product_accepted_count: 1).page(params[:page]).per(params[:limit])
    rsd_products = RsdProduct.all

    render_with_meta_data RsdProducts::Builder.index(rsd_products), rsd_products.count
  end

  def create
  end

  def update
  end

  def delete
  end

  private
  def tags_params
    params.require(:tag).permit(
      :tag_id,
      :clean_tag
    )
  end

  def page_params
    params.permit(:page)
  end

  def sort
    if params[:sort].present? && params[:dir].present?
      "#{params[:sort]} #{params[:dir]}"
    else
      "rsd ASC"
    end
  end
end
