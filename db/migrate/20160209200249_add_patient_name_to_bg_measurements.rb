class AddPatientNameToBgMeasurements < ActiveRecord::Migration
  def change
    add_column :bg_measurements, :patient_name, :string
  end
end
