class JobsSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs_skills do |t|
      t.references :job
      t.references :skill
      t.timestamps
    end
  end
end
