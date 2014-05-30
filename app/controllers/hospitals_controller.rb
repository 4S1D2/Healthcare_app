class HospitalsController < ApplicationController

  def index
    @procedures = []
    temp_procedures = HTTParty.get("https://data.medicare.gov/resource/healthcare-associated-infections.json?%24select=measure&%24where=score%3E%3D0")
    temp_procedures.each do |procedure|
      @procedures.push(procedure["measure"])
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
      results = HTTParty.get("https://data.medicare.gov/resource/healthcare-associated-infections.json?state=#{state}&measure=#{procedure}&%24where=score%3E%3D0&%24order=score")
      return results
  end

end

