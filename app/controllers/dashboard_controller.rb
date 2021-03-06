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
        @pagy, @records = pagy(Job.where(company: @company))
        if @company.name == nil
          redirect_to edit_company_path(@company)
        end
      else
        @company = nil
      end
    elsif user_candidate_signed_in?
      @candidate = Candidate.find(current_user_candidate.id)
      matches_to_exclude = Match.where("job_like = false").pluck(:id)
      @pagy, @matches = pagy(Match.where(candidate: @candidate, candidate_like: true).where.not(id: matches_to_exclude))
    end
  end
end
