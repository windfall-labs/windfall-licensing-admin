class Receipt < ActiveRecord::Base

  establish_connection "licensing_#{Rails.env}".to_sym

end
