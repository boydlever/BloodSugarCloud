json.array!(@bg_measurements) do |bg_measurement|
  json.extract! bg_measurement, :id, :mg_dl, :notes, :patient_id
  json.url bg_measurement_url(bg_measurement, format: :json)
end
