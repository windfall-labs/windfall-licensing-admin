class Tags::Processor
  def initialize params
    @params = params
  end

  def process
    @params.each do |rsd_params|
      rsd_product = RsdProduct.find(rsd_params[:rsd_product_id])
      if rsd_params[:selected]
        RsdProducts::TagsProcessor.new(rsd_product, rsd_params[:tags]).process
      else
        rsd_product.update_attributes(manually_inspected: true)
      end
    end
  end
end
