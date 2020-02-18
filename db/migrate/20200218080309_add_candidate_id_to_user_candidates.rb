class AddCandidateIdToUserCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :user_candidates, :candidate_id, :integer
  end
end
