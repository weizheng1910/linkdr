class DashboardController < ApplicationController
  def index
    @home = true
  end

  def show
    if user_company_signed_in?
      @company = Company.find(params[:id])
      puts @company.job
    elsif user_candidate_signed_in?
      @candidate = Candidate.find(params[:id])
    end
  end
end
