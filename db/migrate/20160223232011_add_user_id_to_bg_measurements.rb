class AddUserIdToBgMeasurements < ActiveRecord::Migration
  def change
    add_column :bg_measurements, :user_id, :integer
  end
end
