class RsdProduct < ActiveRecord::Base

  establish_connection "product_control_#{Rails.env}".to_sym

  def self.filter(search_text, receipt_accepted_count, unique_rejected_count, unique_accepted_count)
    sql = []

    sql << "rsd ILIKE ?" if search_text.present?
    sql << "receipt_accepted_count ILIKE ?" if receipt_accepted_count.present?
    sql << "unique_rejected_count ILIKE ?" if unique_rejected_count.present?
    sql << "unique_accepted_count ILIKE ?" if unique_accepted_count.present?

    values = []

    values << "%#{search_text}%" if search_text.present?
    values << "%#{receipt_accepted_count}% ILIKE ?" if receipt_accepted_count.present?
    values << "%#{unique_rejected_count}% ILIKE ?" if unique_rejected_count.present?
    values << "%#{unique_accepted_count}% ILIKE ?" if unique_accepted_count.present?

    where(sql.join(" OR "), *values)
  end

  def toggle_never_product
    if self.never_product.eql?(true)
      self.update_attribute(:never_product, false)
    else
      self.update_attribute(:never_product, true)
    end
  end
end
