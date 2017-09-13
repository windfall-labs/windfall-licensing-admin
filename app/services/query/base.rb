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
      "wrong_product",
      "banner_id"
    ]
    LIKE_FIELDS = [
      "filter"
    ]
    NOT_IN_FIELDS = [
      "excluded_ids"
    ]

    def initialize key, value, table
      @key = key
      @value = value
      @table = table
    end
  end
end
