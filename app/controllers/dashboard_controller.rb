class DashboardController < ApplicationController
  def index
    @home = true
    if user_company_signed_in? || user_candidate_signed_in?
      if current_user_company
        redirect_to "/companies/" + current_user_company.id.to_s + "/dashboard"
      elsif current_user_candidate
        redirect_to "/candidates/" + current_user_candidate.id.to_s + "/dashboard"
      end
    end
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
