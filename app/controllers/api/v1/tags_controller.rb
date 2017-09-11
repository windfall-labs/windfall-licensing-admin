class Api::V1::TagsController < ApiController
  before_action :find_rsd_product, only: [:create]
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
    rsd_products = RsdProduct.where(product: true).by_limit(page_params).order("unique_accepted_count DESC")

    render_with_meta_data RsdProducts::Builder.index(rsd_products), RsdProduct.count
  end

  def create
    if RsdProducts::TagsProcessor.new(@rsd_product, tags_params[:tags]).process
      render_success
    end
  end

  def update
  end

  def delete
  end

  private
  def tags_params
    params.require(:tag).permit(
      :rsd_product_id,
      tags: []
    )
  end

  def page_params
    {
      page: params[:page] || 1,
      limit: 20
    }
  end

  def sort
    if params[:sort].present? && params[:dir].present?
      "#{params[:sort]} #{params[:dir]}"
    else
      "rsd ASC"
    end
  end

  def find_rsd_product
    @rsd_product = RsdProduct.find(tags_params[:rsd_product_id])
  end
end
