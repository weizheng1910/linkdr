class DashboardController < ApplicationController
  def index
    @home = true
    if user_company_signed_in? || user_candidate_signed_in?
      redirect_to "/dashboard"
    end
  end

  def show
    if user_company_signed_in?
      if current_user_company.company
        @company = Company.find(current_user_company.id)
      else
        @company = nil
      end
    elsif user_candidate_signed_in?
      @candidate = Candidate.find(current_user_candidate.id)
      @matches = Match.where(
        candidate: @candidate,
        job_like: nil,
      )
    end
  end
end
