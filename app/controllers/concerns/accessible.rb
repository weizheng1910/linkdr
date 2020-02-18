module Accessible
  # This concern means that someone cannot log in as a company AND as a candidate at the same time in the same session
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_user_candidate
      flash.clear
      redirect_to('/') and return
    elsif current_user_company
      flash.clear
      redirect_to('/') and return
    end
  end
end
