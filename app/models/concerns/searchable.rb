module Searchable
  extend ActiveSupport::Concern
  module ClassMethods
    SORT_AND_PAGINATION_FIELDS =[
      "limit",
      "page",
      "sort",
      "dir"
    ]
    def search_v2 params
      where(build_query(params)).
      sort_collection(params).
      by_limit(params)
    end

    def sort_collection params
      order(get_sort(params))
    end

    def by_limit params
      page(params[:page]).
      per(params[:limit])
    end

    private
    def build_query params
      string_query = []
      params.each do |key, value|
        next if value.nil? || value == "Any" || value == [""] || value == [] || value == 'All' || value.blank? || SORT_AND_PAGINATION_FIELDS.include?(key)
        string_query << Query::Builder.new(key.to_s, value, self.table_name).process
      end
      string_query.join(" AND ")
    end
    def get_sort params
      if params[:sort].present? && params[:dir].present?
        "#{params[:sort]} #{params[:dir]}"
      else
        ""
      end
    end
  end
end
