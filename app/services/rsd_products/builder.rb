class RsdProducts::Builder
  PAGE_LIMIT = 20

  def self.index(rsd_products)
    rsd_products.map do |rsd_product|
      {
        rsd_product_id: rsd_product.id,
        rsd: rsd_product.rsd,
        tags: rsd_product.tags,
        manually_inspected: rsd_product.manually_inspected
      }
    end
  end
end

# {
# rsd_product_id: 1,
#  rsd: “”,
#  tags: [],
#  manually_inspected: false
#
# }
