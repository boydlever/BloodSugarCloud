class CreateBgMeasurements < ActiveRecord::Migration
  def change
    create_table :bg_measurements do |t|
      t.float :mg_dl
      t.text :notes
      t.references :patient, index: true

      t.timestamps
    end
  end
end
