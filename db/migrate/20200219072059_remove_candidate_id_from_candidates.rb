class RemoveCandidateIdFromCandidates < ActiveRecord::Migration[5.2]
  def change
    remove_column :candidates, :candidate_id
  end
end
