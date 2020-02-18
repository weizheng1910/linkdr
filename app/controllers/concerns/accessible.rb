module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_user_candidate
      flash.clear
      redirect_to(authenticated_user_root_path) and return
    elsif current_user_company
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(authenticated_user_root_path) and return
    end
  end
end
