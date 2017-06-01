class RsdProduct < ActiveRecord::Base

  establish_connection "product_control_#{Rails.env}".to_sym

  def self.filter(search_text)
    sql = []

    sql << "rsd ILIKE ?" if search_text.present?

    values = []

    values << "%#{search_text}%" if search_text.present?

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
