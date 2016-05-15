class BgMeasurementsController < ApplicationController
#  before_action :set_bg_measurement, only: [:show, :edit, :update, :destroy, :update_location]

  # GET /bg_measurements
  # GET /bg_measurements.json
  def index
    if current_user
      params[:user_id] = current_user.id
    end
      @bg_measurements = BgMeasurement.where(:user_id => params[:user_id])
#    end
  end

  # GET /bg_measurements/1
  # GET /bg_measurements/1.json
  def show
    @bg_measurement = BgMeasurement.find(params[:id])
  end

  # GET /bg_measurements/new
  def new
    @bg_measurement = BgMeasurement.new
  end

  # GET /bg_measurements/1/edit
  def edit
    @bg_measurement = BgMeasurement.find(params[:id])
  end

  # POST /bg_measurements
  # POST /bg_measurements.json
  def create
    ap params
    extra_param = params[:extra_param]
    @bg_measurement = BgMeasurement.new
    params["bg_measurement"].each do |k,v|
      next if v.blank?
      @bg_measurement.send("#{k}=".to_sym, v)
    end
    @bg_measurement.user_id = current_user.id
    respond_to do |format|
      if @bg_measurement.save
        #format.html { redirect_to bg_measurement_path(:id => @bg_measurement.id, :extra_param => extra_param), notice: 'Bg measurement was successfully created.' }
        format.html { redirect_to bg_measurement_path(:id => @bg_measurement.id, :extra_param => extra_param), notice: 'Bg measurement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bg_measurement }
      else
        format.html { render action: 'new' }
        format.json { render json: @bg_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_location
    puts "update_location. trying to add #{params[:lat]},#{params[:lat]} to bgmeasurement ##{params[:id].to_i}"
    puts "bgmeasurements count = #{BgMeasurement.count}"
    bg_measurement = nil
    15.times do |i|
      puts "attempt #{i} to find record where id = #{params[:id]}"
      bg_measurement = BgMeasurement.find(params[:id].to_i)
      puts "bgmeasurements count = #{BgMeasurement.count}"
      break if bg_measurement
    end
    puts "found record...proceeding"
    puts "\n\n\nID=#{params[:id]}\n\n\n"
    resp = OpenStruct.new
    resp.status = "It worked!"
    resp.lat = params[:lat]
    resp.lng = params[:lng]
    bg_measurement.lat = params[:lat].to_f
    bg_measurement.lng = params[:lng].to_f
    bg_measurement.save
    if bg_measurement.user.phone_number
      $twilio_client.messages.create(
        :from => "+16509841383",
        :to => "+1#{bg_measurement.user.phone_number}",
        :body => "#{bg_measurement.user.name} just checked his blood sugar. It was #{bg_measurement.mg_dl}. His notes (if any): #{bg_measurement.notes}. Location: http://maps.google.com?q=#{bg_measurement.lat},#{bg_measurement.lng}"
      )
    end
    respond_to do |format|
      format.json { render json: resp }
    #  format.html { }
    end
  end

  # PATCH/PUT /bg_measurements/1
  # PATCH/PUT /bg_measurements/1.json
  def update
    respond_to do |format|
      if @bg_measurement.update(bg_measurement_params)
        format.html { redirect_to @bg_measurement, notice: 'Bg measurement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bg_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bg_measurements/1
  # DELETE /bg_measurements/1.json
  def destroy
    @bg_measurement.destroy
    respond_to do |format|
      format.html { redirect_to bg_measurements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
#    def set_bg_measurement
#      @bg_measurement = BgMeasurement.find(params[:id])
#    end

    # Never trust parameters from the scary internet, only allow the white list through.
#    def bg_measurement_params
#      params.require(:bg_measurement).permit(:mg_dl, :notes, :patient_id, :lat, :lng, :id)
#    end
end
