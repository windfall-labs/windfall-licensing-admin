class RsdProduct < ActiveRecord::Base

	establish_connection "product_control_#{Rails.env}".to_sym

  def self.filter(search_text)
    sql = []

    # sql << "CAST(receipt_id AS TEXT) ILIKE ?" unless search_text.to_i == 0
    # sql << "banner_key ILIKE ?" if search_text.present?
    # sql << "image ILIKE ?" if search_text.present?
    sql << "rsd ILIKE ?" if search_text.present?
    # sql << "old_image_url ILIKE ?" if search_text.present?

    values = []

    # values << "%#{search_text}%" unless search_text.to_i == 0
    # values << "%#{search_text}%" if search_text.present?
    values << "%#{search_text}%" if search_text.present?
    # values << "%#{search_text}%" if search_text.present?

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
