class TagsLog < ActiveRecord::Base
  establish_connection "licensing_#{Rails.env}".to_sym

  belongs_to :clean_tag
  belongs_to :rsd_product
end
