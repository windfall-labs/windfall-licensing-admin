class CleanTag < ActiveRecord::Base
  belongs_to :tag
  establish_connection "licensing_#{Rails.env}".to_sym

  include Searchable
end
