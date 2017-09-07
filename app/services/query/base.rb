module Query
  class Base
    EQUAL_FIELDS = [
      "receipt_accepted_count",
      "unique_rejected_count",
      "unique_accepted_count",
      "accepted_count",
      "rejected_count",
      "alt_product_accepted_count",
      "alt_product",
      "receipt_rejected_count",
      "banner_id",
      "always_a_product",
      "never_product",
      "wrong_product"
    ]
    LIKE_FIELDS = [
      "filter"
    ]

    def initialize key, value, table
      @key = key
      @value = value
      @table = table
    end
  end
end
