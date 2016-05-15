class AddLatLngToBgMeasurements < ActiveRecord::Migration
  def change
    add_column :bg_measurements, :lat, :float
    add_column :bg_measurements, :lng, :float
  end
end
