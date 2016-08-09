class ReceiptImage < ActiveRecord::Base

	establish_connection "licensing_#{Rails.env}".to_sym

  def self.filter(search_text)
    sql = []

    sql << "receipt_id ILIKE ?" unless search_text.to_i == 0
    sql << "banner_key ILIKE ?" if search_text.present?
    sql << "image ILIKE ?" if search_text.present?
    # sql << "old_image_url ILIKE ?" if search_text.present?

    values = []

    values << "%#{search_text}%" unless search_text.to_i == 0
    values << "%#{search_text}%" if search_text.present?
    values << "%#{search_text}%" if search_text.present?
    # values << "%#{search_text}%" if search_text.present?

    where(sql.join(" OR "), *values)
  end

end
