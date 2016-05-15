class BgMeasurement < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :mg_dl, :presence => true
  column_names.each do |col|
    attr_accessible col.to_sym
  end
end
