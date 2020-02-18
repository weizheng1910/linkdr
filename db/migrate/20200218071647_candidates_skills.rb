class CandidatesSkills < ActiveRecord::Migration[5.2]
  def change
  	create_table :candidates_skills do |t|
	  	t.references :candidate
	  	t.references :skill
	  	t.timestamps
	  end
  end
end
