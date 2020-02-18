class Candidates < ActiveRecord::Migration[5.2]
  def change
  	create_table :candidates do |t|
  		t.string :given_name
  		t.string :family_name
  		t.integer :years_of_experience
  		t.string :expected_salary
  		t.integer :candidate_id
  	end
  end
end
