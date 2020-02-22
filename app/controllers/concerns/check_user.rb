module CheckUser
  # This concern means that someone cannot log in as a company AND as a candidate at the same time in the same session
  extend ActiveSupport::Concern
  included do
    before_filter :check_user
  end

  protected
  def check_user
    if current_user_candidate
      puts "CANDIDATEEEEEEEEEEEEE"
      puts "CANDIDATEEEEEEEEEEEEE"
      puts current_user_candidate
      puts "CANDIDATEEEEEEEEEEEEE"
      puts "CANDIDATEEEEEEEEEEEEE"
    elsif current_user_company
      puts "COMPANYY"
      puts "COMPANYY"
      puts current_user_company
      puts "COMPANYY"
      puts "COMPANYY"
    end
  end
end