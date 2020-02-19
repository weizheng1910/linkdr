class DashboardController < ApplicationController
  def index
    @home = true
  end

  def show
    if user_company_signed_in?
      if current_user_company.company
      @company = Company.find(params[:id])
      puts @company.job
      else 
        @company = nil
      end
    elsif user_candidate_signed_in?
      @candidate = Candidate.find(params[:id])
    end
  end
end
