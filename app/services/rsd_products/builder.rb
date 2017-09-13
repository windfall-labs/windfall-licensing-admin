class RsdProducts::Builder
  PAGE_LIMIT = 20
  def initialize params
    @params = params
  end

  def tags_index
    {
      collection: build_collection,
      count: collection.count,
      page: 1
    }
  end
  def build_collection
    rsd_products = collection
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

  def get_tags rsd_product
    tags =  []
    rsd_product.tags_logs.each do |tag|
      tags << (tag.clean_tag.present? ? tag.clean_tag.clean_tag : tag.tag)unless tag.tag.split(' ').size > 1
    end
    tags.size > 0 ? tags : rsd_product.rsd.split(' ')
  end

  def collection
    RsdProduct.includes(tags_logs: :clean_tag).where(query).where("manually_inspected != ?", true).order("unique_accepted_count DESC").by_limit({page: 1, limit: PAGE_LIMIT})
  end

  def query
    query = []
    @params.each do |key, value|
      unless value.blank?
        query_string = Query::Builder.new(key.to_s, value, "rsd_products").process
        query << query_string unless query_string.blank?
      end
    end
    query.join(" AND ")
  end
end

# {
# rsd_product_id: 1,
#  rsd: “”,
#  tags: [],
#  manually_inspected: false
#
# }
