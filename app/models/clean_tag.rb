class CleanTag < ActiveRecord::Base
  establish_connection "licensing_#{Rails.env}".to_sym

  include Searchable

  belongs_to :tag
  has_many :tags_logs
end
