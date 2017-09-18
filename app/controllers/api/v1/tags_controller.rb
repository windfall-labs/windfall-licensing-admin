class Api::V1::TagsController < ApiController
  # before_action :find_rsd_product, only: [:create]
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
    # rsd_products = RsdProduct.where("product = ? AND id not in (?)", true, params[:excluded_ids] || []).by_limit(page_params).order("unique_accepted_count DESC")

    # render_with_meta_data RsdProducts::Builder.index(rsd_products), RsdProduct.count
    render json: RsdProducts::Builder.new(index_params).tags_index
  end

  def create
    if Tags::Processor.new(tags_params).process
      render_success
    end
  end

  def update
  end

  def delete
  end

  private
  def tags_params
    params.require(:tags)
  end

  def index_params
    {
      excluded_ids: JSON.parse(params[:excluded_ids]) || [],
      product: true,
      banner_id: params[:banner_id]
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
    @rsd_product = RsdProduct.includes(:tags_logs).find(tags_params[:rsd_product_id])
  end
end
