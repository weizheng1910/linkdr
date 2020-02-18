class AddUserCandidateIdToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :user_candidate_id, :integer
    remove_column :user_candidates, :candidate_id
  end
end
