class UpcProduct < ActiveRecord::Base
  establish_connection "product_control_#{Rails.env}".to_sym
  include Searchable
end
