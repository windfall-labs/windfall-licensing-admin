class RsdProduct < ActiveRecord::Base

  establish_connection "product_control_#{Rails.env}".to_sym


  def self.filter(search_text, receipt_accepted_count, unique_rejected_count, unique_accepted_count, accepted_count, rejected_count, alt_product_accepted_count, alt_product, receipt_rejected_count)
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


    where(sql.join(" AND "), *values)
  end

  def toggle_never_product
    if self.never_product.eql?(true)
      self.update_attribute(:never_product, false)
    else
      self.update_attribute(:never_product, true)
    end
  end
end
