class RsdProduct < ActiveRecord::Base
  include Searchable
  establish_connection "product_control_#{Rails.env}".to_sym

  has_many :tags_logs

  def tags
    tags_logs = self.tags_logs.where("tag IN (?)", self.rsd.split(" "))
    if tags_logs.present?
      tags_logs.map do |tags_log|
        clean_tag_or_tag(tags_log)
      end
    else
      []
    end
  end

  def self.filter(search_text, receipt_accepted_count, unique_rejected_count, unique_accepted_count, accepted_count, rejected_count, alt_product_accepted_count, alt_product, receipt_rejected_count, banner_id, is_product,never_product,wrong_product)
    sql = []

    sql << "rsd ILIKE ?" if search_text.present?
    sql << "receipt_accepted_count = ?" if receipt_accepted_count.present?
    sql << "unique_rejected_count = ?" if unique_rejected_count.present?
    sql << "unique_accepted_count = ?" if unique_accepted_count.present?
    sql << "accepted_count = ?" if accepted_count.present?
    sql << "rejected_count = ?" if rejected_count.present?
    sql << "alt_product_accepted_count = ?" if alt_product_accepted_count.present?
    sql << "alt_product = ?" if alt_product.present?
    sql << "receipt_rejected_count = ?" if receipt_rejected_count.present?
    sql << "banner_id = ?" if banner_id.present?
    sql << "always_a_product = ?" if is_product.present?
    sql << "never_product = ?" if never_product.present?
    sql << "wrong_product = ?" if wrong_product.present?
    # sql << "always_a_product IS NULL" if is_product.present? && is_product.eql?('false')

    values = []

    values << "%#{search_text}%" if search_text.present?
    values << receipt_accepted_count.to_i if receipt_accepted_count.present?
    values << unique_rejected_count.to_i if unique_rejected_count.present?
    values << unique_accepted_count.to_i if unique_accepted_count.present?
    values << accepted_count.to_i if accepted_count.present?
    values << rejected_count.to_i if rejected_count.present?
    values << alt_product_accepted_count.to_i if alt_product_accepted_count.present?
    values << alt_product if alt_product.present?
    values << receipt_rejected_count.to_i if receipt_rejected_count.present?
    values << banner_id.to_i if banner_id.present?
    if is_product.present?
      values << (is_product.eql?('true') ? true : false)
    end
    values << (never_product.eql?('true') ? true : false) if never_product.present?
    values << (wrong_product.eql?('true') ? true : false) if wrong_product.present?

    joined_sql = sql.join(" AND ")
    joined_sql += " OR always_a_product IS NULL" if (is_product.present? && is_product.eql?('false'))
    where(joined_sql, *values)
  end

  def toggle_field(field)
    if self.send(field.to_sym).eql?(true)
      falsify_fields
    else
      falsify_fields
      self.update_attribute(field.to_sym, true)
    end
  end

  def falsify_fields
    self.update_attributes(never_product: false, always_a_product: false, wrong_product: false)
  end

  private

  def clean_tag_or_tag(tags_log)
    clean_tag = tags_log.clean_tag
    if clean_tag.present?
      clean_tag.clean_tag
    else
      tags_log.tag
    end
  end
end
