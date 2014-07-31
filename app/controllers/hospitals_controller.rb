class HospitalsController < ApplicationController

  def index
    @procedures = []
    temp_procedures = HTTParty.get("http://data.medicare.gov/resource/77hc-ibv8.json?$select=measure_name")
    temp_procedures.each do |procedure|
      # binding.pry
      @procedures.push(procedure["measure_name"])
    end
    @procedures.uniq!
  end

  def search
    @state = params[:state]
    @procedure = params[:procedure]
    @hospitals = get_results(@state, @procedure)
  end

  private

  def get_results(state, procedure)
      procedure = procedure.gsub(" ", "%20")
      temp_results = HTTParty.get("http://data.medicare.gov/resource/77hc-ibv8.json?state=#{state}&measure_name=#{procedure}")
      temp_results.delete_if {|result| result["score"] == "Not Available" || result["score"] == "-"}
      results = temp_results.sort_by do |result|
        result["score"].to_f
      end
      return results
  end

end

