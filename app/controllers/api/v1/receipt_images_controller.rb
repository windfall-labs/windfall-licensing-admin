class Api::V1::ReceiptImagesController < ApiController

  def index
    receipts = ReceiptImage.filter(params[:filter]).
      where(Query::Builder.new("created_at", JSON.parse(params["date_filter"]), "receipt_images").process).
      where(Query::Builder.new("confidence", JSON.parse(params["confidence_filter"]), "receipt_images").process).
      page(params[:page]).per(params[:limit]).order(params["sort"])
    render_with_meta_data receipts, receipts.total_pages
  end

  def preview_images
    next_images = ReceiptImage.where("id > ?", params[:id]).first(5)
    prev_images = ReceiptImage.where("id < ?", params[:id]).last(5)

    render json: {prev_receipts: prev_images, next_images: next_images}
  end

end
