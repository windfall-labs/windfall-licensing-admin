class RsdProducts::Builder
  PAGE_LIMIT = 20

  def self.index(rsd_products)
    rsd_products.map do |rsd_product|
      {
        rsd_product_id: rsd_product.id,
        rsd: rsd_product.rsd,
        tags: get_tags(rsd_product),
        unique_accepted_count: rsd_product.unique_accepted_count,
        manually_inspected: rsd_product.manually_inspected
      }
    end
  end

  def self.get_tags rsd_product
    tags = rsd_product.tags
    if tags.size > 0
      tags
    else
      rsd_product.rsd.split(' ')
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
