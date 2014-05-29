class HospitalsController < ApplicationController

  def index
    #get list of procedures to use in drop down menu

  end

  def search
    #display search results based on state and procedure input
    @procedure = (params[:drg_definition]).gsub(" ","%20").gsub("&", "%26")
    @results = HTTParty.get("http://data.cms.gov/resource/97k6-zzx3.json?$order=average_covered_charges%20ASC&provider_state=#{params[:provider_state]}&drg_definition=#{@procedure}&$$app_token=#{SODA_CLIENT_ID}")
  end

  def new
    @hospital = Hospital.new
  end

  def create
    @hospital = Hospital.new(hospital_params)
  end

  def show
  end

  private

  def hospital_params
    params.require(:hospital).permit(:hospital_name, :address_1, :city, :state, :phone_number)
  end

  def get_zip(zip)
      zip = zip
      # binding.pry
      local_hosp = HTTParty.get("https://data.medicare.gov/resource/healthcare-associated-infections.json?zip_code=#{zip}")
      binding.pry
      return local_hosp
  end

end

