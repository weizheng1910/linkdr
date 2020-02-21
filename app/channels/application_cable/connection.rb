module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = UserCandidate.find_by(id: cookies.signed['user_candidate.id'])
        verified_user
      elsif verified_user = UserCompany.find_by(id: cookies.signed['user_company.id'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end