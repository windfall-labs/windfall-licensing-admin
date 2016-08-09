class Api::V1::ReceiptImagesController < ApiController

	def index
    receipts = ReceiptImage.filter(params[:filter]).page(params[:page]).per(params[:limit])

		render_with_meta_data receipts, receipts.total_pages
	end

end
