module Query
  class Builder < Base
    def process
      field_type = get_field_type
      if field_type.blank?
        ""
      else
        ApplicationRecord.send(:sanitize_sql_array, ["#{get_key_substitute} #{get_operator} ?",get_value_substition])
      end
    end

    def get_key_substitute
      if @key == "filter"
        return @table == "rsd_products" ? "rsd" : "receipt_product_number"
      else
        @key
      end
    end

    def get_value_substition
      if LIKE_FIELDS.include?(@key)
        "%#{@value}%"
      else
        @value
      end
    end

    def get_field_type
      case @key
      when *EQUAL_FIELDS
        "equal"
      when *LIKE_FIELDS
        "like"
      else
        ""
      end
    end

    def get_operator
      case get_field_type
      when "equal"
        "="
      when "like"
        "ILIKE"
      else
        ""
      end
    end

  end
end
