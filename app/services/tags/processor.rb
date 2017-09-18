class Tags::Processor
  def initialize params
    @params = params
  end

  def process
    @params.each do |rsd_params|
      rsd_product = RsdProduct.includes(:tags_logs).where(id: rsd_params[:rsd_product_id], manually_inspected: false).first
      if rsd_product.present?
        if rsd_params[:selected]
          RsdProducts::TagsProcessor.new(rsd_product, rsd_params).process
        else
          rsd_product.update_attributes(manually_inspected: true)
        end
      end
    end
  end
end
