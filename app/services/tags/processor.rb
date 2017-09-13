class Tags::Processor
  def initialize params
    @params = params
  end

  def process
    @params.each do |rsd_params|
      rsd_product = RsdProduct.find(rsd_params[:rsd_product_id])
      RsdProducts::TagsProcessor.new(rsd_product, rsd_params[:tags]).process
    end
  end
end
