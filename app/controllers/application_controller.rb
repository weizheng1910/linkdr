class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_candidate_info
  before_action :set_company_info

protected

  def set_candidate_info
    if current_user_candidate
      @candidate = current_user_candidate.candidate
    end
  end

  def set_company_info
    if current_user_company
      @company = current_user_company.company
    end
  end

end
