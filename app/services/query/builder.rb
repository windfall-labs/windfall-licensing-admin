module Query
  class Builder < Base
    def process
      field_type = get_field_type
      if field_type.blank?
        ""
      elsif field_type == "in" || field_type == "not in"
        ApplicationRecord.send(:sanitize_sql_array, ["#{get_key_substitute} #{get_operator} (?)",get_value_substition])
      else
        ApplicationRecord.send(:sanitize_sql_array, ["#{get_key_substitute} #{get_operator} ?",get_value_substition])
      end
    end

    def get_key_substitute
      if @key == "filter"
        return @table == "rsd_products" ? "rsd" : "receipt_product_number"
      elsif @key == "excluded_ids"
        "id"
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
      when *NOT_IN_FIELDS
        "not in"
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
      when "not in"
        "NOT IN"
      else
        ""
      end
    end

  end
end
